cmake_minimum_required(VERSION 3.16)

project(phpe C)

if (NOT CMAKE_C_STANDARD)
    set(CMAKE_C_STANDARD 99)
endif ()

if (NOT PHP_VERSION)
    set(PHP_VERSION 8.2.6)
endif()

configure_file(src/main.php main.php COPYONLY)

add_executable(phpe src/main.c)

if(WIN32)
    set(PHP_SRC_PATH "${CMAKE_CURRENT_SOURCE_DIR}/vendor/php-sdk-binary-tools/php-${PHP_VERSION}/vs17/x64")
else ()
    set(PHP_SRC_PATH "${CMAKE_CURRENT_SOURCE_DIR}/vendor/php-${PHP_VERSION}")
endif ()

include_directories(
    "${PHP_SRC_PATH}"
    "${PHP_SRC_PATH}/main"
    "${PHP_SRC_PATH}/Zend"
    "${PHP_SRC_PATH}/TSRM"
    "${PHP_SRC_PATH}/ext"
    "${PHP_SRC_PATH}/ext/date/lib"
    "${PHP_SRC_PATH}/sapi"
)

if(WIN32)
    target_link_libraries(phpe PRIVATE ${PHP_SRC_PATH}/x64/Release/php8embed.lib)
else ()
    target_link_libraries(phpe PRIVATE ${PHP_SRC_PATH}/libs/libphp.a
        m
        dl
        resolv
        util
        sodium
        onig
        ffi
        xml2
        sqlite3
        curl
    )
endif ()