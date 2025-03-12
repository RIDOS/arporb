#!/bin/sh

set -e

# Устанавливаем расширения
docker-php-ext-install pdo pdo_pgsql opcache

# Очистка после установки
apt-get clean && rm -rf /var/lib/apt/lists/*
