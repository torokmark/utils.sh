#!/usr/bin/env bash

#####################################################################
##
## title: String Extension
##
## description:
## String extension of shell (bash, ...)
##   with well-known function for string manipulation
## Function list based on:
##   https://docs.oracle.com/javase/7/docs/api/java/lang/String.html
##   https://docs.python.org/2/library/string.html#string-functions
##
## author: Mark Torok
##
## date: 07. Dec. 2016
##
## license: MIT
##
#####################################################################

source "../console.sh"

capitalize() {
  :
}

## pre-condition:
##   - number of params cannot be less than two
##
## params:
##   - str: string : the string we investigate
##   - pos: integer : the position in which the character sits
## return:
##   - retval: character : the character on the passed position
char_at() {
  # pre-conditions:
  [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

  local str="$1"
  local pos="$2"  # pos must be >= 0

  if [[ "$pos" -lt 0 ]]; then
    pos=${#str}
  fi

  local retval
  retval=${str:pos:1}

  echo "$retval"
}

compare_to() {
  # pre-conditions:
  [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

  local left right
  left="$1"
  right="$2"

  local retval

  if [[ "$left" < "$right" ]]; then
    retval=-1
  elif [[ "$left" == "$right" ]]; then
    retval=0
  else
    retval=1
  fi

  echo "$retval"
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

count() {
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

join_fields() {
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

strip() {
  :
}

## Example:
##   begindex
##   begindex, endindex
substring() {
  :
}

swapcase() {
  :
}

title() {
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