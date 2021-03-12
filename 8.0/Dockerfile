FROM php:8.0-fpm

RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-utils \
  libbz2-dev \
  libfreetype6-dev \
  libicu-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libonig-dev \
  libpng-dev \
  libwebp-dev \
  libsodium-dev \
  libxslt1-dev \
  libzip-dev \
  libc-client-dev \
  libkrb5-dev \
  unzip \
  procps \
  zip \
  git \
  vim \
  less \
  wget

RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl

RUN docker-php-ext-install \
  bcmath \
  bz2 \
  calendar \
  exif \
  gd \
  gettext \
  imap \
  intl \
  mbstring \
  mysqli \
  opcache \
  pcntl \
  pdo_mysql \
  soap \
  sockets \
  sodium \
  sysvmsg \
  sysvsem \
  sysvshm \
  xsl \
  zip

RUN pecl channel-update pecl.php.net \
  && pecl install xdebug

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

COPY conf/extra.conf /usr/local/etc/php-fpm.d/zzz-extra.conf
COPY conf/opcache.ini /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
COPY conf/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY conf/extra.ini /usr/local/etc/php/conf.d/zzz-extra.ini

RUN docker-php-ext-enable xdebug

RUN curl -sS https://getcomposer.org/installer | \
  php -- --1 --install-dir=/usr/local/bin --filename=composer

RUN apt-get -y -q autoremove && \
    apt-get -y -q clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN mkdir /scripts
COPY conf/run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

EXPOSE 9000

WORKDIR /app

CMD ["/scripts/run.sh", "php-fpm"]
