cmake_minimum_required(VERSION 3.16)

project(phpe C)

if (NOT CMAKE_C_STANDARD)
    set(CMAKE_C_STANDARD 99)
endif ()

set(PHP_VERSION 8.2.6)
set(PHP_SRC_PATH "${CMAKE_CURRENT_SOURCE_DIR}/vendor/php-${PHP_VERSION}")

include_directories(
        "${PHP_SRC_PATH}"
        "${PHP_SRC_PATH}/main"
        "${PHP_SRC_PATH}/Zend"
        "${PHP_SRC_PATH}/TSRM"
        "${PHP_SRC_PATH}/ext"
        "${PHP_SRC_PATH}/ext/date/lib"
        "${PHP_SRC_PATH}/sapi")

configure_file(src/entrypoint.php src/entrypoint.php COPYONLY)

add_executable(phpe src/main.c)

target_link_libraries(phpe "${PHP_SRC_PATH}/libs/libphp.so")
