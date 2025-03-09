# Stage 1: Build
FROM php:8.3-fpm AS build

# Set working directory
WORKDIR /app

# Устанавливаем зависимости для PHP и Composer
RUN apt-get update && apt-get install -y unzip git curl libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql

# Устанавливаем Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Копируем composer файлы
COPY composer.lock composer.json ./

# Устанавливаем зависимости
RUN composer install --no-dev --prefer-dist --no-scripts --no-progress --no-interaction

# Копируем код приложения
COPY . .

# Stage 2: Run
FROM php:8.3-fpm

# Set working directory
WORKDIR /app

# Копируем зависимости из build stage
COPY --from=build /app/vendor/ vendor/

# Копируем код приложения
COPY . .

# Устанавливаем PostgreSQL dev-пакеты перед запуском расширений
RUN apt-get update && apt-get install -y libpq-dev

# Копируем кастомные настройки PHP
COPY infra/php/custom.ini /usr/local/etc/php/conf.d/custom.ini
COPY infra/php/extensions.sh /usr/local/bin/extensions.sh

# Даем права на выполнение и запускаем установку расширений
RUN chmod +x /usr/local/bin/extensions.sh && /usr/local/bin/extensions.sh

# Открываем порт 9000 для php-fpm
EXPOSE 9000
