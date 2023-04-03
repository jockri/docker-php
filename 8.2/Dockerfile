FROM php:8.2-fpm-alpine

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer /usr/bin/composer /usr/local/bin/

RUN apk add --no-cache \
	bash \
    git \
    grep \
    less \
    procps \
    supervisor \
    vim \
    wget

RUN install-php-extensions \
    amqp \
    bcmath \
    exif \
    gd \
    gettext \
    grpc \
    imagick \
    imap \
    intl \
    opcache \
    pcntl \
    pdo_mysql \
    soap \
    sockets \
    xdebug \
    yaml \
    zip

RUN rm -rf /usr/local/etc/php-fpm.d/zz-docker.conf
COPY conf/extra.ini /usr/local/etc/php/conf.d/
COPY conf/www.conf /usr/local/etc/php-fpm.d/www.conf

ENV COMPOSER_MEMORY_LIMIT=-1

COPY conf/supervisord.conf /etc/supervisord.conf

RUN mkdir /scripts
COPY conf/run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

WORKDIR /app
EXPOSE 9000
CMD ["/scripts/run.sh"]
