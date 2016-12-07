#!/usr/bin/env bash

source "../console.sh"
source "../assert/assert.sh" # it also sources the console.sh
source "../lib/string.sh"

log_header "Test string.sh"

test_char_at() {
  log_header "Test char_at"

  local actual

  actual=$( char_at "apple pear" 4)
  assert_eq "e" "$actual" "Should be e"
  if [ "$?" == 0 ]; then
    log_success "char_at returns e placed on the 4th index of apple..."
  else
    log_failure "char_at should return e"
  fi

  actual=$( char_at "apple pear" 0)
  assert_eq "a" "$actual" "Should be a"
  if [ "$?" == 0 ]; then
    log_success "char_at returns a placed on the 0th index of apple"
  else
    log_failure "char_at should return a as the 0th char"
  fi

  actual=$( char_at "apple pear" 9)
  assert_eq "r" "$actual" "Should be r"
  if [ "$?" == 0 ]; then
    log_success "char_at returns r placed on the last 9th index of apple pear"
  else
    log_failure "char_at should return r as 9th"
  fi

  actual=$( char_at "apple pear" 100)
  assert_eq "" "$actual" "Should be ''"
  if [ "$?" == 0 ]; then
    log_success "char_at returns '' (empty) if index is out of bound"
  else
    log_failure "char_at should return ''"
  fi




}

test_char_at
