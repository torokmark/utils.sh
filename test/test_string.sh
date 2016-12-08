#!/usr/bin/env bash

#####################################################################
##
## description:
## Tests for the string extension
##
## author: Mark Torok
##
## date: 07. Dec. 2016
##
## license: MIT
##
#####################################################################

source "../console.sh"
source "../assert/assert.sh" # it also sources the console.sh
source "../lib/string.sh"

log_header "Test string.sh"

test_capitalize() {
  log_header "Test capitalize"

  local actual

  actual=$( capitalize "apple pear" )
  assert_eq "Apple pear" "$actual" "should be 'Apple pear'"
  if [[ "$?" == 0 ]]; then
    log_success "capitalize returns capitalized 'Apple pear'"
  else
    log_failure "char_at should return 'Apple pear'"
  fi

}

test_char_at() {
  log_header "Test char_at"

  local actual

  actual=$( char_at "apple pear" 4)
  assert_eq "e" "$actual" "Should be e"
  if [[ "$?" == 0 ]]; then
    log_success "char_at returns e placed on the 4th index of apple..."
  else
    log_failure "char_at should return e"
  fi

  actual=$( char_at "apple pear" 0)
  assert_eq "a" "$actual" "Should be a"
  if [[ "$?" == 0 ]]; then
    log_success "char_at returns a placed on the 0th index of apple"
  else
    log_failure "char_at should return a as the 0th char"
  fi

  actual=$( char_at "apple pear" 9)
  assert_eq "r" "$actual" "Should be r"
  if [[ "$?" == 0 ]]; then
    log_success "char_at returns r placed on the last 9th index of apple pear"
  else
    log_failure "char_at should return r as 9th"
  fi

  actual=$( char_at "apple pear" 100)
  assert_eq "" "$actual" "Should be ''"
  if [[ "$?" == 0 ]]; then
    log_success "char_at returns '' (empty) if index is out of bound"
  else
    log_failure "char_at should return ''"
  fi

  actual=$( char_at "apple pear" -1)
  assert_eq "" "$actual" "Should be ''"
  if [[ "$?" == 0 ]]; then
    log_success "char_at returns '' (empty) if index is out of bound from bottom"
  else
    log_failure "char_at should return ''"
  fi

  : '
  char_at "apple pear"
  assert_eq "1" "$?" "Should be 1"
  if [[ "$?" == 0 ]]; then
    log_success "char_at exits when num of params less than two"
  else
    log_failure "char_at should return 1"
  fi
  '
}

test_compare_to() {
  log_header "Test compare_to"

  local actual

  actual=$( compare_to "apple pear" "beer" )
  assert_eq -1 "$actual" "should be -1"
  if [[ "$?" == 0 ]]; then
    log_success "compare_to returns -1 if left lt right lexicographically"
  else
    log_failure "compare_to should return -1"
  fi

  actual=$( compare_to "apple pear" "apple pear" )
  assert_eq 0 "$actual" "should be 0"
  if [[ "$?" == 0 ]]; then
    log_success "compare_to returns 0 if two sides are equal"
  else
    log_failure "compare_to should return 0"
  fi

  actual=$( compare_to "apple pear" "apfel" )
  assert_eq 1 "$actual" "should be 1"
  if [[ "$?" == 0 ]]; then
    log_success "compare_to returns 1 if left lt right lexicographically"
  else
    log_failure "compare_to should return 1"
  fi

  actual=$( compare_to "Apple pear" "APple pear" )
  assert_eq -1 "$actual" "should be -1"
  if [[ "$?" == 0 ]]; then
    log_success "compare_to returns -1 if left lt right lexicographically (case sensitive)"
  else
    log_failure "compare_to should return -1 (case sensitive)"
  fi

  actual=$( compare_to "blueberry" "APPLE PEAR" )
  assert_eq 1 "$actual" "should be 1"
  if [[ "$?" == 0 ]]; then
    log_success "compare_to returns 1 if left gt right lexicographically (case sensitive)"
  else
    log_failure "compare_to should return 1 (case sensitive)"
  fi
}

test_compare_to_ignore_case() {
  log_header "Test compare_to_ignore_case"

  local actual

  actual=$( compare_to_ignore_case "apple pear" "beer" )
  assert_eq -1 "$actual" "should be -1"
  if [[ "$?" == 0 ]]; then
    log_success "compare_to_ignore_case returns 1 if left gt right"
  else
    log_failure "compare_to_ignore_case should return 1"
  fi

  actual=$( compare_to_ignore_case "APplE peAR" "apple pear" )
  assert_eq 0 "$actual" "should be 0"
  if [[ "$?" == 0 ]]; then
    log_success "compare_to_ignore_case returns 0 if two sides are equal"
  else
    log_failure "compare_to_ignore_case should return 0"
  fi

  actual=$( compare_to_ignore_case "APple pear" "apfel" )
  assert_eq 1 "$actual" "should be 1"
  if [[ "$?" == 0 ]]; then
    log_success "compare_to_ignore_case returns 1 if left lt right"
  else
    log_failure "compare_to_ignore_case should return 1"
  fi
}

test_concat() {
  log_header "Test concat"

  log_warning "Pending tests"
}

test_contains() {
  log_header "Test contains"

  log_warning "Pending tests"
}




# test calls

test_capitalize
test_char_at
test_compare_to
test_compare_to_ignore_case
test_concat
test_contains