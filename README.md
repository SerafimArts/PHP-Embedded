# Embedded PHP

An example of using the Embedded PHP SAPI

## Building

### Linux/Debian

- Make sure you are using Docker `Linux Containers`
- Build Docker Image
  ```sh
  docker compose up --build phpe-debian
  ```
- An assembly will be in `build/php-X.Y.Z/phpe`

### Windows/LTSC2022

> TODO: Not implemented yet

- Make sure you are using Docker `Windows Containers`
  > An error like "no match for platform in manifest" means that you 
  > use the Linux Containers.
- Build Docker Image
  ```sh
  docker compose up --build phpe-windows
  ```
- An assembly will be in `build/php-X.Y.Z/phpe.exe`
