#!/bin/sh

if [ -z "$PHP_VERSION" ]; then
  export PHP_VERSION=8.2.6
fi

export PHP_URL="https://www.php.net/distributions/php-$PHP_VERSION.tar.xz"

if [ ! -f "/home/phpe/vendor/php-$PHP_VERSION.tar.xz" ]; then
  # download repository
  echo "Downloading PHP $PHP_VERSION"
  wget -O /home/phpe/vendor/php-$PHP_VERSION.tar.xz "$PHP_URL";

  # extract repository
  echo "Extracting archive into /home/phpe/vendor/php-$PHP_VERSION"

  mkdir -p "/home/phpe/vendor/php-$PHP_VERSION"
  tar -Jxf /home/phpe/vendor/php-$PHP_VERSION.tar.xz -C "/home/phpe/vendor/php-$PHP_VERSION" --strip-components=1
fi