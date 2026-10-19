FROM php:8.3-apache

ARG GRAV_VERSION=latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        unzip libzip-dev libpng-dev libjpeg62-turbo-dev libfreetype6-dev libyaml-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" zip gd opcache \
    && pecl install apcu yaml \
    && docker-php-ext-enable apcu yaml \
    && a2enmod rewrite expires headers remoteip \
    && rm -rf /var/lib/apt/lists/*

# Allow .htaccess (Grav routing)
RUN sed -ri 's!AllowOverride None!AllowOverride All!g' /etc/apache2/apache2.conf

WORKDIR /var/www
RUN curl -fsSL -o grav.zip "https://getgrav.org/download/core/grav/${GRAV_VERSION}" \
    && unzip -q grav.zip \
    && rm -rf html grav.zip \
    && mv grav html

WORKDIR /var/www/html

COPY user/config ./user/config
COPY user/pages ./user/pages

RUN bin/gpm install -y saturn form email pagination feed taxonomylist error problems admin \
    && chown -R www-data:www-data /var/www/html

EXPOSE 80
