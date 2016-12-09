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
    log_success "compare_to_ignore_case returns 0 if two sides are equal (ignore case)"
  else
    log_failure "compare_to_ignore_case should return 0"
  fi

  actual=$( compare_to_ignore_case "APple pear" "apfel" )
  assert_eq 1 "$actual" "should be 1"
  if [[ "$?" == 0 ]]; then
    log_success "compare_to_ignore_case returns 1 if left gt right (ignore case)"
  else
    log_failure "compare_to_ignore_case should return 1"
  fi
}

test_concat() {
  log_header "Test concat"

  local actual

  actual=$( concat "apple" "pear" )
  assert_eq "applepear" "$actual" "should be applepear"
  if [[ "$?" == 0 ]]; then
    log_success "concat returns concatenation of the two params"
  else
    log_failure "concat should return applepear"
  fi

  actual=$( concat "apple" "" )
  assert_eq "apple" "$actual" "should be apple"
  if [[ "$?" == 0 ]]; then
    log_success "concat returns the word if the other one is empty"
  else
    log_failure "concat should return apple"
  fi

  actual=$( concat "" "" )
  assert_eq "" "$actual" "should be ''"
  if [[ "$?" == 0 ]]; then
    log_success "concat returns empty string if params are empty"
  else
    log_failure "concat should return ''"
  fi
}

test_contains() {
  log_header "Test contains"

  local actual

  actual=$( contains "apple" "ppl" )
  assert_eq true "$actual" "should be true"
  if [[ "$?" == 0 ]]; then
    log_success "contains returns true if first string contains the second"
  else
    log_failure "contains should return true"
  fi

  actual=$( contains "apple" "pear" )
  assert_eq false "$actual" "should be false"
  if [[ "$?" == 0 ]]; then
    log_success "contains returns false if first string not contains the second"
  else
    log_failure "contains should return false"
  fi

  actual=$( contains "apple" "" )
  assert_eq true "$actual" "should be true"
  if [[ "$?" == 0 ]]; then
    log_success "contains returns true if second string is '' (empty)"
  else
    log_failure "contains should return true"
  fi
}

test_count() {
  log_header "Test count"

  local actual

  actual=$( count "apple pear" "p" )
  assert_eq 3 "$actual" "should be 3"
  if [[ "$?" == 0 ]]; then
    log_success "count returns 3 if found three matches of characters"
  else
    log_failure "count should return 3"
  fi

  actual=$( count "applea pear" "ea" )
  assert_eq 2 "$actual" "should be 2"
  if [[ "$?" == 0 ]]; then
    log_success "count returns 2 if found two matches of substrings"
  else
    log_failure "count should return 2"
  fi

  actual=$( count "applea pear" "peach" )
  assert_eq 0 "$actual" "should be 0"
  if [[ "$?" == 0 ]]; then
    log_success "count returns 0 if no maching found"
  else
    log_failure "count should return 0"
  fi

  actual=$( count "applea pear" "applea pear" )
  assert_eq 1 "$actual" "should be 1"
  if [[ "$?" == 0 ]]; then
    log_success "count returns 1 if the pattern matches the whole string"
  else
    log_failure "count should return 1"
  fi

}

test_ends_with() {
  log_header "Test ends_with"

  local actual

  actual=$( ends_with "apple" "le" )
  assert_eq true "$actual" "should be true"
  if [[ "$?" == 0 ]]; then
    log_success "ends_with returns true if pattern mathes with the end of the string"
  else
    log_failure "ends_with should return true"
  fi

  actual=$( ends_with "apple" "lea" )
  assert_eq false "$actual" "should be false"
  if [[ "$?" == 0 ]]; then
    log_success "ends_with returns false if no mathing found"
  else
    log_failure "ends_with should return false"
  fi

  actual=$( ends_with "apple" "" )
  assert_eq true "$actual" "should be true"
  if [[ "$?" == 0 ]]; then
    log_success "ends_with returns true if pattern is '' (empty) string"
  else
    log_failure "ends_with should return true"
  fi

  actual=$( ends_with "apple" "apple" )
  assert_eq true "$actual" "should be true"
  if [[ "$?" == 0 ]]; then
    log_success "ends_with returns true if pattern is same as the string"
  else
    log_failure "ends_with should return true"
  fi
}

test_equals() {
  log_header "Test equals"

  local actual

  actual=$( equals "apple pear" "apple pear" )
  assert_eq true "$actual" "should be true"
  if [[ "$?" == 0 ]]; then
    log_success "equals returns true if the two sides are equivalent"
  else
    log_failure "equals should return true"
  fi

  actual=$( equals "apple pear" "apple" )
  assert_eq false "$actual" "should be false"
  if [[ "$?" == 0 ]]; then
    log_success "equals returns false if the two sides are not equivalent"
  else
    log_failure "equals should return false"
  fi

  log_warning "equals returns false if the two sides are not equivalent (case sensitive)"
}

test_equals_ignore_case() {
  log_header "Test equals_ignore_case"

  log_warning "Pending tests"
}

test_format() {
  log_header "Test format"

  log_warning "Pending tests"
}

test_index_of() {
  log_header "Test index_of"

  log_warning "Pending tests"
}

test_is_empty() {
  log_header "Test is_empty"

  local actual

  actual=$( is_empty "" )
  assert_eq true "$actual" "should be true"
  if [[ "$?" == 0 ]]; then
    log_success "is_empty returns true if the parameter string is empty and 0 length"
  else
    log_failure "is_empty should return true"
  fi

  actual=$( is_empty "apple" )
  assert_eq false "$actual" "should be false"
  if [[ "$?" == 0 ]]; then
    log_success "is_empty returns false if the parameter is a character string"
  else
    log_failure "is_empty should return false"
  fi

  actual=$( is_empty "\n" )
  assert_eq false "$actual" "should be false"
  if [[ "$?" == 0 ]]; then
    log_success "is_empty returns false if the parameter is a whitespace"
  else
    log_failure "is_empty should return false"
  fi
}

test_join_fields() {
  log_header "Test join_fields"

  log_warning "Pending tests"
}

test_last_index_of() {
  log_header "Test last_index_of"

  log_warning "Pending tests"
}

test_length() {
  log_header "Test length"

  log_warning "Pending tests"
}

test_matches() {
  log_header "Test matches"

  log_warning "Pending tests"
}

test_replace() {
  log_header "Test replace"

  log_warning "Pending tests"
}

test_replace_all() {
  log_header "Test replace_all"

  log_warning "Pending tests"
}

test_replace_first() {
  log_header "Test replace_first"

  log_warning "Pending tests"
}

test_starts_with() {
 log_header "Test starts_with"

 log_warning "Pending tests"

}




# test calls

test_capitalize
test_char_at
test_compare_to
test_compare_to_ignore_case
test_concat
test_contains
# test_count
test_ends_with
test_equals
test_equals_ignore_case
test_format
test_index_of
test_is_empty
test_join_fields
test_last_index_of
test_length
test_matches
test_replace
test_replace_all
test_replace_first
test_starts_with