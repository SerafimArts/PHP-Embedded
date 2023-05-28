# Embedded PHP

An example of using the Embedded PHP SAPI

## Building (Docker)

- Build Docker Image
  ```sh
  docker build -t phpe .
  ```
- Compile Sources
```sh
docker run \
    --mount type=bind,source="$(pwd)",target=/home/phpe \
    phpe /home/phpe/docker/build.sh
```

### Usage (Docker)

- An assembly will be in `build/phpe`

```sh
./build/phpe
```

## Building (Linux/WSL)

- Download sources into `vendor/php-X.Y.Z`
  - Build source (see: https://github.com/php/php-src#building-php-source-code):
  ```sh
  # Like this
  cd vendor/php-X.Y.Z
  ./buildconf
  ./configure --enable-embed=static --disable-all
  make -j "$(nproc)";
  ``` 
- Open `CMakeLists.txt`
  - Put your PHP version into `set(PHP_VERSION X.Y.Z)`
- Configure assembly:
  ```sh
  cmake -DCMAKE_BUILD_TYPE=Release -G 'CodeBlocks - Unix Makefiles' -S . -B ./build
  ```
- Build binary:
  ```sh
  cmake --build ./build --target phpe
  ```

### Usage (Linux/WSL)

- An assembly will be in `build/phpe`

```sh
./build/phpe
```