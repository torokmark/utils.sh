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
  # pre-conditions:
  [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1
  local str="$1"

  local retval
  retval="${str^}"

  echo "$retval"
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

# like sort method
# Apple pear < APple peAr
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
  elif [[ "$left" > "$right" ]]; then
    retval=1
  else
    log_failure "[Unhandled state]"
  fi

  echo "$retval"
}

compare_to_ignore_case() {
  # pre-conditions:
  [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

  local left right
  left="${1,,}"
  right="${2,,}"

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

concat() {
  # pre-conditions:
  [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

  local left right
  left="$1"
  right="$2"

  local retval
  retval+="$left$right"

  echo "$retval"
}

contains() {
  # pre-conditions:
  [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

  local left right
  left="$1"
  right="$2"

  local retval
  retval=false

  if [[ "$left" == *"$right"* ]]; then
    retval=true
  fi

  echo "$retval"
}

count() {
  # pre-conditions:
  [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

  local str pattern
  str="$1"
  pattern="$2"

  local retval
  local char_str char_pat
  retval=0
  if [[ "${#pattern}" -le "${#str}" ]]; then
    for (( i=0; i<"${#str}"; i+=1 )); do
      for (( j=0; j<"${#pattern}"; j+=1 )); do
        char_str="${str:$i+$j:1}"
        char_pat="${pattern:$j:1}"
        if [[ ! "$char_str" == "$char_pat" ]]; then
          continue 2 # ugly mish-mashing! TODO: fix it
        fi
      done
      (( retval+=1 ))
    done
  else
    retval=0
  fi

  echo "$retval"
}

ends_with() {
  # pre-conditions:
  [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

  local str pattern
  str="$1"
  pattern="$2"

  local retval

  if [[ "$str" == *"$pattern" ]]; then
    retval=true
  else
    retval=false
  fi

  echo "$retval"
}

equals() {
   # pre-conditions:
  [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

  local str pattern
  str="$1"
  pattern="$2"

  local retval

  if [[ "$str" == "$pattern" ]]; then
    retval=true
  else
    retval=false
  fi

  echo "$retval"
}

equals_ignore_case() {
  # pre-conditions:
  [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

  local str pattern
  str="${1,,}"
  pattern="${2,,}"

  local retval

  if [[ "$str" == "$pattern" ]]; then
    retval=true
  else
    retval=false
  fi

  echo "$retval"
}

format() {
  :
}

## Example:
##   index_of "apple" "p" -> 1
##   index_of "apple" "pl" -> 2
##   index_of "apple" "p" 2 -> 2
index_of() {
  # pre-conditions:
  [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

  local str char
  str="$1"
  char="$2"

  local retval
  retval=false

  local x
  x="${1%%$2*}"
  log_info "xxx :: $x"
  [[ $x = $1 ]] && echo -1 || echo ${#x}

  echo "$retval"
}

is_empty() {
  # pre-conditions:
  [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1

  local str
  str="$1"

  local retval
  retval=false

  if [[ -z "$str" ]]; then
    retval=true
  fi

  echo "$retval"
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