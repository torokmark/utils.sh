#!/usr/bin/env bash

if [ ! -d 'vendor/assert.sh' ]; then
  git clone git@github.com:torokmark/assert.sh.git vendor/assert.sh 
fi
bash "./test/tests.sh"
 
