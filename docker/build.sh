#!/bin/sh

if [ -z "$PHP_VERSION" ]; then
  export PHP_VERSION=8.2.6
fi

/home/phpe/docker/download.sh
/home/phpe/docker/make.sh

echo 'Prepare...'
mkdir -p /home/phpe/build

echo 'Building...'
cmake -DCMAKE_BUILD_TYPE=Release -G 'CodeBlocks - Unix Makefiles' -S /home/phpe -B /home/phpe/build

echo 'Compile...'
cmake --build /home/phpe/build --target phpe