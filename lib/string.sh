#!/usr/bin/env bash

#####################################################################
##
## String extension of shell (bash, ...)
##   with well-known function for string manipulation
## Function list based on:
##   https://docs.oracle.com/javase/7/docs/api/java/lang/String.html
##
## @author Mark Torok
##
## @date: 07. Dec. 2016
##
## @license MIT
##
#####################################################################

source "../console.sh"

char_at() {
  local str="$1"
  local pos="$2"  # pos must be >= 0

  local retval
  retval=${str:pos:1}

  echo "$retval"
}

compare_to() {
  :
}

compare_to_ignore_case() {
  :
}

concat() {
  :
}

contains() {
  :
}

ends_with() {
  :
}

equals() {
  :
}

equals_ignore_case() {
  :
}

format() {
  :
}

## Example:
##   index_of "apple" "p" -> 1
##   index_of "apple" "pl" -> 2
##   index_of "apple" "p" 2 -> 2
index_of() {
  :
}

is_empty() {
  :
}

## Example:
##   last_index_of "apple" "p" -> 2
##   last_index_of "apple" "pl" -> 2
##   last_index_of "apple" "p" 2 -> 0
last_index_of() {
  :
}

length() {
  :
}

matches() {
  :
}

## Example:
##   replace "apple" "p" "c" -> accle
##   replace "apple" "pp" "c" -> acle
replace() {
  :
}

replace_all() {
  :
}

replace_first() {
  :
}

## Example:
##   -
##   -
starts_with() {
  :
}

## Example:
##   begindex
##   begindex, endindex
substring() {
  :
}

to_lower_case() {
  :
}

to_upper_case() {
  :
}

trim() {
  :
}