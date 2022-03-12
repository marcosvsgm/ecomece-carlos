FROM php:8.0-fpm-alpine
# Copy composer.lock and composer.json
COPY composer.json /var/www/html/
ARG ENV_TYPE
# Set working directory
WORKDIR /var/www/html

RUN apk add -Uuv \
    git bash supervisor freetype-dev libjpeg-turbo-dev libzip-dev \
    libpng-dev postgresql-dev nginx \
    && rm -rf /var/cache/apk/*
ENV PHPREDIS_VERSION 5.3.2



RUN apk -v --update add \
        python2 \
        py-pip \
        groff \
        less \
        mailcap \
        && \
    pip install --upgrade awscli==1.20.11 s3cmd==2.1.0 python-magic && \
    rm /var/cache/apk/*
RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
RUN apk --no-cache add shadow
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY --chown=www-data:www-data . /var/www/html

RUN usermod -a -G www-data root
#Configure Nginx
COPY deploy-ecs/config-docker/nginx.conf /etc/nginx/nginx.conf
COPY deploy-ecs/config-docker/install-extensions.sh /opt/install-extensions.sh
# Configure PHP-FPM
COPY deploy-ecs/config-docker/fpm-pool.conf /etc/php/php-fpm.d/www.conf
COPY deploy-ecs/config-docker/php.ini /etc/php/conf.d/custom.ini
# Configure supervisord
COPY deploy-ecs/config-docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chmod +x /opt/install-extensions.sh
RUN /opt/install-extensions.sh
RUN mkdir -p storage/framework/cache storage/framework/sessions storage/framework/views
# RUN usermod -u 1000 www-data
RUN chown -R www-data:www-data /var/www/html
RUN chmod +x ./deploy-ecs/run.sh
# RUN composer install

VOLUME ["/storage"]
ENTRYPOINT ["sh","./deploy-ecs/run.sh"]
# USER www-data
# CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
EXPOSE 80
# Configure a healthcheck to validate that everything is up&running

#   HEALTHCHECK --timeout=15s CMD curl --silent --fail http://127.0.0.1/elb-status
