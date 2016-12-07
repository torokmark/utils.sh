#!/usr/bin/env bash

source "../console.sh"
source "./assert.sh"

test_assert_eq() {
  log_header "Test :: assert_eq"

  assert_eq "Hello" "Hello"
  if [ "$?" == 0 ]; then
    log_success "Two 'Hello's are equivalent"
  else
    log_failure "We have a problem"
  fi

  assert_eq "Hello" "World"
  if [ "$?" == 1 ]; then
    log_success "assert_eq returns 1 if two words are not equal"
  else
    log_failure "Obviously the two words are not equivalent"
  fi
  : '
  assert_eq "Hello" "Hello" "Equals message"
  if [ "$?" == 0 ]; then
    log_success "Two \"Hello\"s are equivalent"
  else
    log_failure "We have a problem"
  fi

  assert_eq "Hello" "World" "Equals message"
  if [ "$?" == 0 ]; then
    log_success "Two \"Hello\"s are equivalent"
  else
    log_failure "Other message comes as well"
  fi
  '
}

test_assert_not_eq() {
  log_header "Test :: assert_not_eq"

  assert_not_eq "Hello" "Hello"
  if [ "$?" == 1 ]; then
    log_success "The two words are equivalent"
  else
    log_failure "assert_not_eq does not work"
  fi

  assert_not_eq "Hello" "World"
  if [ "$?" == 0 ]; then
    log_success "assert_not_eq returns 0 if two params are not equal"
  else
    log_failure "assert_not_eq does not work"
  fi
}

test_assert_true() {
  log_header "Test :: assert_true"

  assert_true true
  if [ "$?" == 0 ]; then
    log_success "assert_true returns 0 if param is true"
  else
    log_failure "assert_true does not work"
  fi

  assert_true false
  if [ "$?" == 1 ]; then
    log_success "assert_true returns 1 if param is false"
  else
    log_failure "assert_true does not work"
  fi
}

test_assert_false() {
  log_header "Test :: assert_false"

  assert_false false
  if [ "$?" == 0 ]; then
    log_success "assert_false returns 0 if param is false"
  else
    log_failure "assert_false does not work"
  fi

  assert_false true
  if [ "$?" == 1 ]; then
    log_success "assert_false returns 1 if param is true"
  else
    log_failure "assert_false does not work"
  fi
}

test_assert_array_eq() {
  log_header "Test :: assert_array_eq"

  declare -a exp
  declare -a act
  : '
  assert_array_eq ("one" "tw oo" "333") ("one" "tw oo" "333")
  if [ "$?" == 0 ]; then
    log_success "assert_array_eq returns 0 if two arrays are equal by values"
  else
    log_failure "assert_array_eq should be equal"
  fi
  '
  exp=("one")
  act=("one" "tw oo" "333")
  assert_array_eq exp[@] act[@] "Different length"  # it can be an issue on other implementation of shell
  if [ "$?" == 1 ]; then
    log_success "assert_array_eq returns 1 if the lengths of the two arrays are not equal"
  else
    log_failure "assert_array_eq should be equal"
  fi
  : '
  assert_array_eq ("one" "222" "333") ("one" "tw oo" "333")
  if [ "$?" == 1 ]; then
    log_success "assert_array_eq returns 1 if two arrays are not equal"
  else
    log_failure "assert_array_eq should be equal"
  fi

  assert_array_eq () ("one" "tw oo" "333")
  if [ "$?" == 1 ]; then
    log_success "assert_array_eq returns 1 if two arrays are not equal"
  else
    log_failure "assert_array_eq should be equal"
  fi
  '
}

test_assert_array_not_eq() {
  log_header "Test :: assert_array_not_eq"

  log_warning "Pending tests"
}

test_assert_empty() {
  log_header "Test :: assert_empty"

  assert_empty ""
  if [ "$?" == 0 ]; then
    log_success "assert_empty returns 0 if param is empty string"
  else
    log_failure "assert_empty does not work"
  fi

  assert_empty "some text"
  if [ "$?" == 1 ]; then
    log_success "assert_empty returns 1 if param is some text string"
  else
    log_failure "assert_empty does not work"
  fi

  assert_empty "\n"
  if [ "$?" == 1 ]; then
    log_success "assert_empty returns 1 if param is some white space"
  else
    log_failure "assert_empty does not work"
  fi
}

test_assert_not_empty() {
  log_header "Test :: assert_not_empty"

  assert_not_empty "some text"
  if [ "$?" == 0 ]; then
    log_success "assert_not_empty returns 0 if param is some text string"
  else
    log_failure "assert_not_empty does not work"
  fi

  assert_not_empty "\n"
  if [ "$?" == 0 ]; then
    log_success "assert_not_empty returns 0 if param is some white space"
  else
    log_failure "assert_not_empty does not work"
  fi

  assert_not_empty ""
  if [ "$?" == 1 ]; then
    log_success "assert_not_empty returns 1 if param is empty string"
  else
    log_failure "assert_not_empty does not work"
  fi
}


# test calls

test_assert_eq
test_assert_not_eq
test_assert_true
test_assert_false
test_assert_array_eq
test_assert_array_not_eq
test_assert_empty
test_assert_not_empty