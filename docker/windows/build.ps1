$PHP_ARCH   = "x64"
$PHP_TARGET = "obj-x64"
$PHP_CONFIG = "nts-windows-vs16-x64-avx"

$PHP_SDK_TOOLS_VERSION = "2.2.0"
$PHP_SDK_TOOLS = "c:/phpe/vendor/php-sdk-$PHP_SDK_TOOLS_VERSION"

#
# Download PHP SDK
#

if (-Not (Test-Path $PHP_SDK_TOOLS)) {
    git clone --progress https://github.com/php/php-sdk-binary-tools.git $PHP_SDK_TOOLS
}

cd $PHP_SDK_TOOLS
git checkout php-sdk-$PHP_SDK_TOOLS_VERSION

#
# Building PHP
#

cd $PHP_SDK_TOOLS/bin

While($true) {}
