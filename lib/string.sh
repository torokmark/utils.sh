#!/usr/bin/env bash


char_at() {
  local STR="$1"
  local POS="$2"
  local retval

  retval=${STR:POS:1}
  echo "$retval"
}
