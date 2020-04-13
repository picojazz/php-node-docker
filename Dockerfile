FROM php:7.3.0-apache

RUN curl -sSk https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get update && apt-get install -y git libzip-dev unzip \
    && docker-php-ext-install zip \
    && a2enmod rewrite headers

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt install -y nodejs

RUN addgroup --system picojazz --gid 1000 && adduser --system picojazz --uid 1000 --ingroup picojazz
#USER picojazz
COPY . /var/www/html
WORKDIR /var/www/html/app

RUN composer install
