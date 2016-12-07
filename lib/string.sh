#!/usr/bin/env bash

source "../console.sh"

char_at() {
  local str="$1"
  local pos="$2"  # pos must be >= 0

  local retval
  retval=${str:pos:1}

  echo "$retval"
}
