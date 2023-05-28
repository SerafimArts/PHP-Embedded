#include <sapi/embed/php_embed.h>

const char EMBEDDED_PHP_INI[] =
    "html_errors=0\n"
    "register_argc_argv=1\n"
    "implicit_flush=1\n"
    "output_buffering=0\n"
    "max_execution_time=0\n"
    "memory_limit=-1\n"
    "ffi.enable=1\n"
    "max_input_time=-1\n\0";

bool execute_file(const char* filename)
{
    bool return_value = false;
    zend_file_handle file_handle;

    zend_stream_init_filename(&file_handle, filename);
    return_value = php_execute_script(&file_handle);
    zend_destroy_file_handle(&file_handle);

    return return_value;
}

int main(int argc, char **argv)
{
    //
    // Prepare SAPI
    //
    php_embed_module.name = "cli\0";
    php_embed_module.ini_entries = malloc(sizeof(EMBEDDED_PHP_INI));

    //
    // Execute SAPI
    //
    PHP_EMBED_START_BLOCK(argc, argv)

    execute_file("main.php");

    PHP_EMBED_END_BLOCK()
}
