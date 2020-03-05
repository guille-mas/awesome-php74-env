# My PHP Development environment
FROM php:7.4.2-apache AS dev-image

# arguments available at build time
ARG HTTP_PORT
ARG HTTPS_PORT
ARG PROJECT_NAME
ARG APP_ROOT_DIR

# environment variables available at build time and run time
ENV COMPOSER_HOME="/usr/local/composer/global"

RUN apt-get update \
    # Install debian packages
    && apt-get install -yq --no-install-recommends dialog apt-utils openssl ssl-cert curl git unzip libzip-dev \
    # install php extensions
    && pecl install xdebug-2.9.2 zip \
    && docker-php-ext-enable xdebug opcache zip \
    # set up self signed cert (the easy way)
    && make-ssl-cert generate-default-snakeoil --force-overwrite \
    && chown -R www-data:www-data /etc/ssl/certs /etc/ssl/private \
    # enable SSL apache module
    && a2enmod ssl \
    # Create data folders for XDebug
    # tracing and profiling tools
    # and set ownership to www-data
    && mkdir -p /tmp/${PROJECT_NAME} \
    && chown -R www-data:www-data /tmp/${PROJECT_NAME} \
    # Install PHP Composer package manager
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer \
    && mkdir -p /usr/local/composer/global \
    && chown -R www-data:www-data /usr/local/composer/global \
    # cleaning...
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
# copy development settings for PHP
COPY ./config/php-dev.ini /usr/local/etc/php/conf.d/
# override default apache configuration
COPY ./config/apache-vhost.conf /etc/apache2/sites-enabled/000-default.conf
COPY ./config/apache-ports.conf /etc/apache2/ports.conf
# copy the PHP source code inside your image
COPY --chown=www-data:www-data ./src ${APP_ROOT_DIR}
WORKDIR ${APP_ROOT_DIR}
# expose HTTP and HTTPS ports
EXPOSE ${HTTP_PORT} ${HTTPS_PORT}
USER www-data
