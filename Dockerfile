FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ARG PHP_VERSION 8.0

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y php$PHP_VERSION php$PHP_VERSION-xdebug

RUN touch /var/log/xdebug.log && chmod 0777 /var/log/xdebug.log

COPY xdebug.ini /etc/php/$PHP_VERSION/cli/conf.d/xdebug.ini

# Replace the
ARG XDEBUG_MODE=debug
RUN sed -i "s/XDEBUG_MODE/$XDEBUG_MODE/g" /etc/php/$PHP_VERSION/cli/conf.d/xdebug.ini

COPY php-benchmark-script/bench.php /var/www/html/bench.php
