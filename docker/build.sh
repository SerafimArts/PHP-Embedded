#!/bin/sh

if [ -z "$PHP_VERSION" ]; then
  export PHP_VERSION=8.2.6
fi

export PHP_URL="https://www.php.net/distributions/php-$PHP_VERSION.tar.xz"

ROOT_DIR="$( realpath -e -- "$( dirname "$0" )/.."; )"
export ROOT_DIR

VENDOR_DIR="$( realpath -e -- "$( dirname "$0" )/../vendor"; )"
export VENDOR_DIR

BUILD_DIR="$( realpath -e -- "$( dirname "$0" )/../build"; )"
export BUILD_DIR

#
# EXECUTE
#

# download repository
if [ ! -f "${VENDOR_DIR}/php-$PHP_VERSION.tar.xz" ]; then
  echo "Downloading PHP $PHP_VERSION"
  wget -O ${VENDOR_DIR}/php-$PHP_VERSION.tar.xz "$PHP_URL";
fi

# extract repository
if [ ! -f "${VENDOR_DIR}/php-$PHP_VERSION/buildconf" ]; then
    echo "Extracting sources into ${VENDOR_DIR}/php-$PHP_VERSION"

    mkdir -p "${VENDOR_DIR}/php-$PHP_VERSION"
    tar -Jxf "${VENDOR_DIR}/php-$PHP_VERSION.tar.xz" -C "${VENDOR_DIR}/php-$PHP_VERSION" --strip-components=1
fi

cd "${VENDOR_DIR}/php-$PHP_VERSION" || exit 1

# configure
if [ ! -f "${VENDOR_DIR}/php-$PHP_VERSION/Zend/zend_config.h" ]; then
  ./configure \
    --enable-embed=static \
    --enable-shmop \
    --enable-sockets \
    --enable-mbstring \
    --without-pear \
    --disable-cli \
    --disable-cgi \
    --disable-short-tags \
    --disable-session \
    --with-ffi \
    --with-curl
fi

# compile
make -j "$(nproc)";

echo "Creating build directory ${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

echo 'Building...'
cmake -DCMAKE_BUILD_TYPE=Release -G 'CodeBlocks - Unix Makefiles' -S "${ROOT_DIR}" -B "${BUILD_DIR}"

echo 'Compile...'
cmake --build "${BUILD_DIR}" --target phpe