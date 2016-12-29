#!/usr/bin/env bash

source "$IMPORT_HOME"

dn=$( dirname "$BASH_SOURCE" )

import "$dn/test_import_shell_helper.sh"

test_import_shell_helper_func
