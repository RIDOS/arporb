#!/bin/sh

set -e

# Установка необходимых таблиц
bin/console doctrine:migration:sync-metadata-storage
bin/console doctrine:migration:migrate

exec php-fpm
