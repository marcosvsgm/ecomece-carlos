#!/bin/sh

    set -e
    usermod -a -G www-data root
    php artisan clear-compiled &&
    php artisan cache:clear &&
    php artisan route:clear &&
    php artisan view:clear &&
    php artisan config:clear &&
    # composer dumpautoload -o;
composer install --optimize-autoloader --prefer-dist
cp ./deploy-ecs/config-docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
/usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
