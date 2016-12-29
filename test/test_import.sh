#!/usr/bin/env bash

source "$IMPORT_HOME"

import "$ROOT_DIR/test/import/test_import_shell.sh"
import "/c/Users/tmark/test_import_home.sh"
test_import_home_func


import "$ROOT_DIR/test/import/import_recursive/*"

#import "$ROOT_DIR/"