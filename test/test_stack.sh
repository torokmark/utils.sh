#!/usr/bin/env bash

#####################################################################
##
## description:
## Tests for the stack extension
##
## author: Mihaly Csokas
##
## date: 14. feb. 2018
##
## license: MIT
##
#####################################################################

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR/../lib/console.sh"
source "$DIR/../vendor/assert.sh/assert.sh"
source "$DIR/../lib/stack.sh"

test_stack()(
  log_header "Test stack.sh"

  test_create() {
    log_header "Test create"

    local actual

    stack create fruits
    actual=$(declare -p fruits)
    assert_eq "declare -a fruits" "$actual" "should be 'declare -a fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "create creates an empty stack 'fruits'"
    else
      log_failure "create should return 'declare -a fruits'"
    fi

    unset fruits
  }

  test_push() {
    log_header "Test push"

    local actual

    stack create fruits

    stack push fruits "apple"
    actual=$(declare -p fruits)
    assert_eq 'declare -a fruits=([0]="apple")' "$actual" 'should be declare -a fruits=([0]="apple")'
    if [[ "$?" == 0 ]]; then
      log_success "push apple to stack 'fruits'"
    else
      log_failure "push should push apple to fruits"
    fi

    stack push fruits "pear"
    actual=$(declare -p fruits)
    assert_eq 'declare -a fruits=([0]="apple" [1]="pear")' \
      "$actual" 'should be declare -a fruits=([0]="apple" [1]="pear")'
    if [[ "$?" == 0 ]]; then
      log_success "push pear to stack 'fruits'"
    else
      log_failure "push should push pear to fruits"
    fi

    stack push fruits "peach"
    actual=$(declare -p fruits)
    assert_eq 'declare -a fruits=([0]="apple" [1]="pear" [2]="peach")' \
      "$actual" 'should be declare -a fruits=([0]="apple" [1]="pear" [2]="peach")'
    if [[ "$?" == 0 ]]; then
      log_success "push peach to stack 'fruits'"
    else
      log_failure "push should push peach to fruits"
    fi

    unset fruits
  }

  test_size() {
    log_header "Test size"

    stack create fruits

    local actual

    actual=$(stack size fruits)
    assert_eq '0' "$actual" 'should be 0'
    if [[ "$?" == 0 ]]; then
      log_success "fruits size is 0"
    else
      log_failure "size should return 0"
    fi

    stack push fruits "apple"
    stack push fruits "pear"
    stack push fruits "peach"

    actual=$(stack size fruits)
    assert_eq '3' "$actual" 'should be 3'
    if [[ "$?" == 0 ]]; then
      log_success "fruits size is 3"
    else
      log_failure "size should return 3"
    fi

    unset fruits
  }

  test_empty() {
    log_header "Test empty"

    stack create fruits
    local actual

    actual=$(stack empty fruits)
    assert_eq 'true' "$actual" 'true'
    if [[ "$?" == 0 ]]; then
      log_success "fruits is empty"
    else
      log_failure "empty should return true"
    fi

    stack push fruits "apple"

    actual=$(stack empty fruits)
    assert_eq 'false' "$actual" 'should be false'
    if [[ "$?" == 0 ]]; then
      log_success "fruits is not empty"
    else
      log_failure "empty should return false"
    fi

    stack pop fruits

    actual=$(stack empty fruits)
    assert_eq 'true' "$actual" 'should be true'
    if [[ "$?" == 0 ]]; then
      log_success "fruits after pop is empty"
    else
      log_failure "empty should return true"
    fi

    unset fruits
  }

  test_pop() {
    log_header "Test pop"

    stack create fruits
    stack push fruits "apple"
    stack push fruits "pear"
    stack push fruits "peach"

    local actual

    stack pop fruits
    actual=$(stack top fruits)

    assert_eq "pear" "$actual" "should be pear"
    if [[ "$?" == 0 ]]; then
      log_success "pop peach from 'fruits'"
    else
      log_failure "pop should remove peach from fruits"
    fi

    stack pop fruits
    actual=$(stack top fruits)

    assert_eq "apple" "$actual" "should be apple"
    if [[ "$?" == 0 ]]; then
      log_success "pop pear from 'fruits'"
    else
      log_failure "pop should remove pear from fruits"
    fi

    stack pop fruits
    actual=$(stack top fruits)

    assert_eq "" "$actual" 'should be ""'
    if [[ "$?" == 0 ]]; then
      log_success "pop apple from 'fruits'"
    else
      log_failure "pop should remove apple from fruits"
    fi

    unset fruits
  }

  test_top() {
    log_header "Test top"

    stack create fruits
    stack push fruits "apple"
    stack push fruits "pear"
    stack push fruits "peach"

    local actual

    actual=$(stack top fruits)
    assert_eq 'peach' "$actual" 'should be peach'
    if [[ "$?" == 0 ]]; then
      log_success "top element is peach"
    else
      log_failure "top should retur peach"
    fi

    stack pop fruits
    actual=$(stack top fruits)
    assert_eq 'pear' "$actual" 'should be pear'
    if [[ "$?" == 0 ]]; then
      log_success "top element is pear"
    else
      log_failure "top should retur pear"
    fi

    unset fruits
  }

  test_clear() {
    log_header "Test clear"

    local actual

    stack create fruits
    stack clear fruits
    actual=$(declare -p fruits)
    assert_eq "declare -a fruits" "$actual" "should be 'declare -a fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "clear clears an empty stack 'fruits'"
    else
      log_failure "clear should return 'declare -a fruits'"
    fi

    stack create fruits
    stack push fruits "apple"
    stack push fruits "pear"
    stack clear fruits
    actual=$(declare -p fruits)
    assert_eq "declare -a fruits" "$actual" "should be 'declare -a fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "clear clears a non empty stack 'fruits'"
    else
      log_failure "clear should return 'declare -a fruits'"
    fi

    unset fruits
  }

  test_destroy() {
    log_header "Test destroy"

    stack create fruits
    stack push fruits "apple"
    stack destroy fruits

    [[ ${fruits} ]] && log_failure "fruits not destroyed"\
                    || log_success "fruits destroyed"

    unset fruits
  }

  # test calls

  test_create
  test_push
  test_size
  test_empty
  test_pop
  test_top
  test_clear
  test_destroy

)

test_stack
