FROM php:7.2-fpm

MAINTAINER yuklia

# upgrade the container
RUN apt-get update && \
    apt-get upgrade -y


RUN apt-get install -y --force-yes gnupg curl git nano zlib1g-dev nodejs \
    && docker-php-ext-install zip pdo pdo_mysql \
    && docker-php-ext-enable zip 

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

# Install composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    printf "\nPATH=\"~/.composer/vendor/bin:\$PATH\"\n" | tee -a ~/.bashrc


# composer plugin for parallel install

RUN composer global require "hirak/prestissimo"

RUN composer global require "laravel/envoy"

RUN composer global require "laravel/installer"

RUN composer global update --no-scripts  

RUN ln -s /var/www/artisan /usr/local/bin/ \
&& ln -s /vendor/bin/phpunit /usr/local/bin/

WORKDIR /code

COPY . /code

RUN composer install

RUN mv .env.example .env
RUN php artisan key:generate
RUN chown -R www-data:www-data /code
