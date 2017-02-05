#!/usr/bin/env bash

source "$IMPORT_HOME"

import_relative "import_relative_inner/test_import_relative_first.sh"

test_import_relative_func() {
  echo "test_import_relative_func is called"
  test_import_relative_first_func
}
