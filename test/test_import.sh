#!/usr/bin/env bash

source "$IMPORT_HOME"

#import "" # Error

#import "./test/import/test_import_shell.sh"
#test_import_shell_func

#import "./test/import/directory/*"
#test_import_directory_func
#test_import_directory_second_func

import "./test/import/directory/recursive/**"
test_import_directory_recursive_one_depth_func
test_import_directory_recursive_one_depth_second_func
test_import_directory_recursive_two_depth_func
test_import_directory_recursive_two_depth_second_func
