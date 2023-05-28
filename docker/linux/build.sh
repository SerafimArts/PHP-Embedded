#!/bin/sh

if [ -z "$PHP_VERSION" ]; then
  echo "PHP_VERSION variable required"
  exit 1
fi

ROOT_DIR="$( realpath -e -- "$( dirname "$0" )/../.."; )"
export ROOT_DIR

DOWNLOAD_DIR="${ROOT_DIR}/vendor"
export DOWNLOAD_DIR

SOURCE_DIR="${ROOT_DIR}/vendor"
export SOURCE_DIR

BUILD_DIR="${ROOT_DIR}/build/php-$PHP_VERSION"
export BUILD_DIR

#
# EXECUTE
#

# download repository
if [ ! -f "${DOWNLOAD_DIR}/php-$PHP_VERSION.tar.xz" ]; then
  echo "Downloading PHP $PHP_VERSION"
  wget -O ${DOWNLOAD_DIR}/php-$PHP_VERSION.tar.xz "https://www.php.net/distributions/php-$PHP_VERSION.tar.xz";
fi

# extract repository
if [ ! -f "${SOURCE_DIR}/php-$PHP_VERSION/buildconf" ]; then
    echo "Extracting sources into ${SOURCE_DIR}/php-$PHP_VERSION"

    mkdir -p "${SOURCE_DIR}/php-$PHP_VERSION"
    tar -Jxf "${DOWNLOAD_DIR}/php-$PHP_VERSION.tar.xz" -C "${SOURCE_DIR}/php-$PHP_VERSION" --strip-components=1
fi

cd "${SOURCE_DIR}/php-$PHP_VERSION" || exit 1

# configure
if [ ! -f "${SOURCE_DIR}/php-$PHP_VERSION/Zend/zend_config.h" ]; then
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

echo " - Creating build directory ${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

echo " - Building ${BUILD_DIR}"
cmake -DCMAKE_BUILD_TYPE=Release -S "${ROOT_DIR}" -B "${BUILD_DIR}"

echo " - Compile ${BUILD_DIR}"
cmake --build "${BUILD_DIR}" --target phpe

echo " - Executing ${BUILD_DIR}/phpe"
cd "${BUILD_DIR}"
./phpe
