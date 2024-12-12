FROM php:7.2-fpm

WORKDIR /

RUN sed -i 's#http://deb.debian.org#https://mirrors.163.com#g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y vim unzip wget libpng-dev libjpeg62-turbo-dev libfreetype6-dev libevent-dev libmcrypt-dev libssl-dev libxml2-dev librdkafka-dev libbz2-dev gcc autoconf

RUN docker-php-source extract \
&& docker-php-ext-configure gd  --with-jpeg-dir  \
&& docker-php-ext-install -j$(nproc) sockets gd pcntl bz2 pdo_mysql bcmath zip \
&& docker-php-source delete

RUN printf "\n" | pecl install rdkafka-6.0.3 \
&&  printf "\n" | pecl install apcu-5.1.23 \
&&  printf "\n" | pecl install redis-6.0.2 \
&&  printf "\n" | pecl install event-3.1.4 \
&&  printf "\n" | pecl install swoole-4.8.13 \
&&  printf "\n" | pecl install nsq-3.5.1 \
&&  pecl install psr-1.1.0 \
&&  pecl install mongodb-1.16.2 \
&&  pecl install xdebug-3.1.6 \
&&  docker-php-ext-enable psr rdkafka apcu mongodb redis event nsq swoole xdebug \
&& rm -rf /tmp/pear

RUN mkdir -p /tmp/phalcon \
&& cd /tmp/phalcon \
&& wget -O phaclon3.4.zip  https://github.com/phalcon/cphalcon/archive/refs/heads/3.4.x.zip \
&& unzip phaclon3.4.zip \
&& cd cphalcon-3.4.x/build \
&& ./install \
&& docker-php-ext-enable phalcon \
&& cd /tmp/ && rm -rf /tmp/phalcon


