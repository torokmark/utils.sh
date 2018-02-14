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

source "../lib/console.sh"
source "../vendor/assert.sh/assert.sh" # it also sources the console.sh
source "../lib/string.sh"

test_string()(
  log_header "Test string.sh"

  test_capitalize() {
    log_header "Test capitalize"

    local actual

    actual=$( string capitalize "apple pear" )
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

    actual=$( string char_at "apple pear" 4)
    assert_eq "e" "$actual" "Should be e"
    if [[ "$?" == 0 ]]; then
      log_success "char_at returns e placed on the 4th index of apple..."
    else
      log_failure "char_at should return e"
    fi

    actual=$( string char_at "apple pear" 0)
    assert_eq "a" "$actual" "Should be a"
    if [[ "$?" == 0 ]]; then
      log_success "char_at returns a placed on the 0th index of apple"
    else
      log_failure "char_at should return a as the 0th char"
    fi

    actual=$( string char_at "apple pear" 9)
    assert_eq "r" "$actual" "Should be r"
    if [[ "$?" == 0 ]]; then
      log_success "char_at returns r placed on the last 9th index of apple pear"
    else
      log_failure "char_at should return r as 9th"
    fi

    actual=$( string char_at "apple pear" 100)
    assert_eq "" "$actual" "Should be ''"
    if [[ "$?" == 0 ]]; then
      log_success "char_at returns '' (empty) if index is out of bound"
    else
      log_failure "char_at should return ''"
    fi

    actual=$( string char_at "apple pear" -1)
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

    actual=$( string compare_to "apple pear" "beer" )
    assert_eq -1 "$actual" "should be -1"
    if [[ "$?" == 0 ]]; then
      log_success "compare_to returns -1 if left lt right lexicographically"
    else
      log_failure "compare_to should return -1"
    fi

    actual=$( string compare_to "apple pear" "apple pear" )
    assert_eq 0 "$actual" "should be 0"
    if [[ "$?" == 0 ]]; then
      log_success "compare_to returns 0 if two sides are equal"
    else
      log_failure "compare_to should return 0"
    fi

    actual=$( string compare_to "apple pear" "apfel" )
    assert_eq 1 "$actual" "should be 1"
    if [[ "$?" == 0 ]]; then
      log_success "compare_to returns 1 if left lt right lexicographically"
    else
      log_failure "compare_to should return 1"
    fi

    actual=$( string compare_to "Apple pear" "APple pear" )
    assert_eq -1 "$actual" "should be -1"
    if [[ "$?" == 0 ]]; then
      log_success "compare_to returns -1 if left lt right lexicographically (case sensitive)"
    else
      log_failure "compare_to should return -1 (case sensitive)"
    fi

    actual=$( string compare_to "blueberry" "APPLE PEAR" )
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

    actual=$( string compare_to_ignore_case "apple pear" "beer" )
    assert_eq -1 "$actual" "should be -1"
    if [[ "$?" == 0 ]]; then
      log_success "compare_to_ignore_case returns 1 if left gt right"
    else
      log_failure "compare_to_ignore_case should return 1"
    fi

    actual=$( string compare_to_ignore_case "APplE peAR" "apple pear" )
    assert_eq 0 "$actual" "should be 0"
    if [[ "$?" == 0 ]]; then
      log_success "compare_to_ignore_case returns 0 if two sides are equal (ignore case)"
    else
      log_failure "compare_to_ignore_case should return 0"
    fi

    actual=$( string compare_to_ignore_case "APple pear" "apfel" )
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

    actual=$( string concat "apple" "pear" )
    assert_eq "applepear" "$actual" "should be applepear"
    if [[ "$?" == 0 ]]; then
      log_success "concat returns concatenation of the two params"
    else
      log_failure "concat should return applepear"
    fi

    actual=$( string concat "apple" "" )
    assert_eq "apple" "$actual" "should be apple"
    if [[ "$?" == 0 ]]; then
      log_success "concat returns the word if the other one is empty"
    else
      log_failure "concat should return apple"
    fi

    actual=$( string concat "" "" )
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

    actual=$( string contains "apple" "ppl" )
    assert_eq true "$actual" "should be true"
    if [[ "$?" == 0 ]]; then
      log_success "contains returns true if first string contains the second"
    else
      log_failure "contains should return true"
    fi

    actual=$( string contains "apple" "pear" )
    assert_eq false "$actual" "should be false"
    if [[ "$?" == 0 ]]; then
      log_success "contains returns false if first string not contains the second"
    else
      log_failure "contains should return false"
    fi

    actual=$( string contains "apple" "" )
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

    actual=$( string count "apple pear" "p" )
    assert_eq 3 "$actual" "should be 3"
    if [[ "$?" == 0 ]]; then
      log_success "count returns 3 if found three matches of characters"
    else
      log_failure "count should return 3"
    fi

    actual=$( string count "applea pear" "ea" )
    assert_eq 2 "$actual" "should be 2"
    if [[ "$?" == 0 ]]; then
      log_success "count returns 2 if found two matches of substrings"
    else
      log_failure "count should return 2"
    fi

    actual=$( string count "applea pear" "peach" )
    assert_eq 0 "$actual" "should be 0"
    if [[ "$?" == 0 ]]; then
      log_success "count returns 0 if no maching found"
    else
      log_failure "count should return 0"
    fi

    actual=$( string count "applea pear" "applea pear" )
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

    actual=$( string ends_with "apple" "le" )
    assert_eq true "$actual" "should be true"
    if [[ "$?" == 0 ]]; then
      log_success "ends_with returns true if pattern mathes with the end of the string"
    else
      log_failure "ends_with should return true"
    fi

    actual=$( string ends_with "apple" "lea" )
    assert_eq false "$actual" "should be false"
    if [[ "$?" == 0 ]]; then
      log_success "ends_with returns false if no mathing found"
    else
      log_failure "ends_with should return false"
    fi

    actual=$( string ends_with "apple" "" )
    assert_eq true "$actual" "should be true"
    if [[ "$?" == 0 ]]; then
      log_success "ends_with returns true if pattern is '' (empty) string"
    else
      log_failure "ends_with should return true"
    fi

    actual=$( string ends_with "apple" "apple" )
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

    actual=$( string equals "apple pear" "apple pear" )
    assert_eq true "$actual" "should be true"
    if [[ "$?" == 0 ]]; then
      log_success "equals returns true if the two sides are equivalent"
    else
      log_failure "equals should return true"
    fi

    actual=$( string equals "apple pear" "apple" )
    assert_eq false "$actual" "should be false"
    if [[ "$?" == 0 ]]; then
      log_success "equals returns false if the two sides are not equivalent"
    else
      log_failure "equals should return false"
    fi

    actual=$( string equals "apple pear" "APple PEaR" )
    assert_eq false "$actual" "should be false"
    if [[ "$?" == 0 ]]; then
      log_success "equals returns false if the two sides are not equivalent (case sensitive)"
    else
      log_failure "equals should return false"
    fi
  }

  test_equals_ignore_case() {
    log_header "Test equals_ignore_case"

    local actual

    actual=$( string equals_ignore_case "apple pear" "apple pear" )
    assert_eq true "$actual" "should be true"
    if [[ "$?" == 0 ]]; then
      log_success "equals_ignore_case returns true if the two sides are equivalent"
    else
      log_failure "equals_ignore_case should return true"
    fi

    actual=$( string equals_ignore_case "apple pear" "apple" )
    assert_eq false "$actual" "should be false"
    if [[ "$?" == 0 ]]; then
      log_success "equals_ignore_case returns false if the two sides are not equivalent"
    else
      log_failure "equals_ignore_case should return false"
    fi

    actual=$( string equals_ignore_case "apple pear" "APple PEaR" )
    assert_eq true "$actual" "should be true"
    if [[ "$?" == 0 ]]; then
      log_success "equals_ignore_case returns true if the two sides are not equivalent (case sensitive)"
    else
      log_failure "equals_ignore_case should return true"
    fi
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

    actual=$( string is_empty "" )
    assert_eq true "$actual" "should be true"
    if [[ "$?" == 0 ]]; then
      log_success "is_empty returns true if the parameter string is empty and 0 length"
    else
      log_failure "is_empty should return true"
    fi

    actual=$( string is_empty "apple" )
    assert_eq false "$actual" "should be false"
    if [[ "$?" == 0 ]]; then
      log_success "is_empty returns false if the parameter is a character string"
    else
      log_failure "is_empty should return false"
    fi

    actual=$( string is_empty "\n" )
    assert_eq false "$actual" "should be false"
    if [[ "$?" == 0 ]]; then
      log_success "is_empty returns false if the parameter is a whitespace"
    else
      log_failure "is_empty should return false"
    fi
  }

  test_join_fields() {
    log_header "Test join_fields"

    local actual

    actual=$( string join_fields "-" "apple" "pear" "peach" )
    assert_eq "apple-pear-peach" "$actual" "should be appletree"
    if [[ "$?" == 0 ]]; then
      log_success "join_fields \"-\" \"apple\" \"pear\" \"peach\" returns the concatenation of params with separator: apple-pear-peach"
    else
      log_failure "join_fields should return applaatraaaa"
    fi
  }

  test_last_index_of() {
    log_header "Test last_index_of"

    local actual

    actual=$( string last_index_of "apple" "p" )
    assert_eq 2 "$actual" "should be 2"
    if [[ "$?" == 0 ]]; then
      log_success "last_index_of returns 2, the index of the last p in apple"
    else
      log_failure "last_index_of should return 2"
    fi

    actual=$( string last_index_of "apple" "le" )
    assert_eq 3 "$actual" "should be 3"
    if [[ "$?" == 0 ]]; then
      log_success "last_index_of returns 3, the index of the last \"le\" in apple"
    else
      log_failure "last_index_of should return 3"
    fi
  }

  test_length() {
    log_header "Test length"

    local actual

    actual=$( string length "apple" )
    assert_eq 5 "$actual" "should be 5"
    if [[ "$?" == 0 ]]; then
      log_success "length returns 5, apple contains 5 characters"
    else
      log_failure "length should return 5"
    fi
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

    local actual

    actual=$( string replace_all "appletree" "e" "aa" )
    assert_eq "applaatraaaa" "$actual" "should be applaatraaaa"
    if [[ "$?" == 0 ]]; then
      log_success "replace_all replace all e to aa in appletree, output should be applaatraaaa"
    else
      log_failure "replace_all should return applaatraaaa"
    fi

  }

  test_replace_first() {
    log_header "Test replace_first"

    local actual

    actual=$( string replace_first "apple" "p" "eee" )
    assert_eq "aeeeple" "$actual" "should be aeeeple"
    if [[ "$?" == 0 ]]; then
      log_success "replace_first replace first p to eee, output should be aeeeple"
    else
      log_failure "replace_first should return aeeeple"
    fi
  }

  test_starts_with() {
   log_header "Test starts_with"

   local actual

   actual=$( string starts_with "apple" "app" )
   assert_eq true "$actual" "should be true"
   if [[ "$?" == 0 ]]; then
     log_success "starts_with returns true, apple starts with app"
   else
     log_failure "starts_with should return true"
   fi

  }

  test_stip() {
   log_header "Test strip"

   local actual

   actual=$( string strip "---apple---" "-" )
   assert_eq "apple" "$actual" "should be apple"
   if [[ "$?" == 0 ]]; then
     log_success "strip returns apple without starting and ending \"-\" chars"
   else
     log_failure "strip should return apple"
   fi

  }

  test_substring() {
   log_header "Test substring"

   local actual

   actual=$( string substring "apple" "2" )
   assert_eq "ple" "$actual" "should be ple"
   if [[ "$?" == 0 ]]; then
     log_success "substring returns ple"
   else
     log_failure "substring should return ple"
   fi

   actual=$( string substring "apple" "2" "4" )
   assert_eq "pl" "$actual" "should be pl"
   if [[ "$?" == 0 ]]; then
     log_success "substring returns pl"
   else
     log_failure "substring should return ple"
   fi

  }

  test_swapcase() {
   log_header "Test swapcase"

   local actual

   actual=$( string swapcase "aPPle" )
   assert_eq "AppLE" "$actual" "should be AppLE"
   if [[ "$?" == 0 ]]; then
     log_success "swapcase returns AppLE"
   else
     log_failure "swapcase should return AppLE"
   fi

  }

  test_title() {
   log_header "Test title"

   local actual

   actual=$( string title "apple pear peach" )
   assert_eq "Apple Pear Peach" "$actual" "should be Apple Pear Peach"
   if [[ "$?" == 0 ]]; then
     log_success "title returns the first param in which first characters of all the words are capitalized"
   else
     log_failure "title should return Apple Pear Peach"
   fi

  }

  test_to_lower_case() {
   log_header "Test to_lower_case"

   local actual

   actual=$( string to_lower_case "aPPLe" )
   assert_eq "apple" "$actual" "should be apple"
   if [[ "$?" == 0 ]]; then
     log_success "to_lower_case converts all of the characters in first the param to lower case"
   else
     log_failure "to_lower_case should return apple"
   fi

  }

  test_to_upper_case() {
   log_header "Test to_upper_case"

   local actual

   actual=$( string to_upper_case "apple" )
   assert_eq "APPLE" "$actual" "should be APPLE"
   if [[ "$?" == 0 ]]; then
     log_success "to_upper_case converts all of the characters in first the param to upper case"
   else
     log_failure "to_upper_case should return APPLE"
   fi

  }

  test_trim() {
   log_header "Test trim"

   local actual

   actual=$( string trim "apple  " )
   assert_eq "apple" "$actual" "should be apple"
   if [[ "$?" == 0 ]]; then
     log_success "trim returns the first param, with leading and trailing whitespace omitted."
   else
     log_failure "trim should return apple"
   fi
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
  test_stip
  test_substring
  test_swapcase
  test_title
  test_to_lower_case
  test_to_upper_case
  test_trim

)

test_string
