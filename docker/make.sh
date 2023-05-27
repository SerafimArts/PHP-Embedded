#!/bin/sh

if [ -z "$PHP_VERSION" ]; then
  export PHP_VERSION=8.2.6
fi

if [ ! -f "/home/phpe/vendor/php-$PHP_VERSION/Zend/zend_config.h" ]; then
  cd /home/phpe/vendor/php-$PHP_VERSION || exit 1

  # building vendor
  ./configure \
    --without-pear \
    --with-sodium \
    --with-ffi \
    --enable-embed \
    --disable-short-tags \
    --disable-cli \
    --disable-cgi
  make -j "$(nproc)";
fi