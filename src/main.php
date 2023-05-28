<?php

echo 'SAPI: ' . php_sapi_name() . "\n";

var_dump(get_loaded_extensions());
var_dump($_SERVER);
