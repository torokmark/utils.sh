#!/usr/bin/env bash

source "../console.sh"
source "../assert/assert.sh" # it also sources the console.sh
source "../lib/string.sh"

log_header "Test string.sh"

test_char_at() {
  log_header "Test char_at"

  log_warning "char_at returns 4 as the index of l in apple"
  log_warning "char_at returns 1 as the index of the first char"
  log_warning "char_at returns 2 as the first appearance of the car of p in apple"
  log_warning "char_at returns -1 as the index of the non-containing char"
}

test_char_at
