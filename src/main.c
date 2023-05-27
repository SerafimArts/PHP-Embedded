#include <sapi/embed/php_embed.h>

int main(int argc, char **argv)
{
    PHP_EMBED_START_BLOCK(argc, argv)

    zend_file_handle file_handle;
    zend_stream_init_filename(&file_handle, "entrypoint.php");
    php_execute_script(&file_handle);

    PHP_EMBED_END_BLOCK()
}