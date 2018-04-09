#!/usr/bin/env bash

#####################################################################
##
## description:
## Tests for the queue extension
##
## author: Mihaly Csokas
##
## date: 17. feb. 2018
##
## license: MIT
##
#####################################################################

source "../lib/console.sh"
source "../vendor/assert.sh/assert.sh" # it also sources the console.sh
source "../lib/queue.sh"

test_queue()(
  log_header "Test queue.sh"

  test_create() {
    log_header "Test create"

    local actual

    queue create fruits
    actual=$(declare -p fruits)
    assert_eq "declare -a fruits" "$actual" "should be 'declare -a fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "create creates an empty queue 'fruits'"
    else
      log_failure "create should return 'declare -a fruits'"
    fi

    unset fruits
  }

  test_enqueue() {
    log_header "Test enqueue"

    local actual

    queue create fruits

    queue enqueue fruits "apple"
    actual=$(declare -p fruits)
    assert_eq 'declare -a fruits=([0]="apple")' "$actual" 'should be declare -a fruits=([0]="apple")'
    if [[ "$?" == 0 ]]; then
      log_success "enqueue apple to queue 'fruits'"
    else
      log_failure "enqueue should push apple to fruits"
    fi

    queue enqueue fruits "pear"
    actual=$(declare -p fruits)
    assert_eq 'declare -a fruits=([0]="apple" [1]="pear")' \
      "$actual" 'should be declare -a fruits=([0]="apple" [1]="pear")'
    if [[ "$?" == 0 ]]; then
      log_success "enqueue pear to queue 'fruits'"
    else
      log_failure "enqueue should enqueue pear to fruits"
    fi

    queue enqueue fruits "peach"
    actual=$(declare -p fruits)
    assert_eq 'declare -a fruits=([0]="apple" [1]="pear" [2]="peach")' \
      "$actual" 'should be declare -a fruits=([0]="apple" [1]="pear" [2]="peach")'
    if [[ "$?" == 0 ]]; then
      log_success "enqueue peach to queue 'fruits'"
    else
      log_failure "enqueue should enqueue peach to fruits"
    fi

    unset fruits
  }

  test_size() {
    log_header "Test size"

    queue create fruits

    local actual

    actual=$(queue size fruits)
    assert_eq '0' "$actual" 'should be 0'
    if [[ "$?" == 0 ]]; then
      log_success "fruits size is 0"
    else
      log_failure "size should return 0"
    fi

    queue enqueue fruits "apple"
    queue enqueue fruits "pear"
    queue enqueue fruits "peach"

    actual=$(queue size fruits)
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

    queue create fruits
    local actual

    actual=$(queue empty fruits)
    assert_eq 'true' "$actual" 'true'
    if [[ "$?" == 0 ]]; then
      log_success "fruits is empty"
    else
      log_failure "empty should return true"
    fi

    queue enqueue fruits "apple"

    actual=$(queue empty fruits)
    assert_eq 'false' "$actual" 'should be false'
    if [[ "$?" == 0 ]]; then
      log_success "fruits is not empty"
    else
      log_failure "empty should return false"
    fi

    queue dequeue fruits

    actual=$(queue empty fruits)
    assert_eq 'true' "$actual" 'should be true'
    if [[ "$?" == 0 ]]; then
      log_success "fruits after dequeue is empty"
    else
      log_failure "empty should return true"
    fi

    unset fruits
  }

  test_dequeue() {
    log_header "Test dequeue"

    queue create fruits
    queue enqueue fruits "apple"
    queue enqueue fruits "pear"
    queue enqueue fruits "peach"

    local actual

    queue dequeue fruits
    actual=$(queue peek fruits)

    assert_eq "pear" "$actual" "should be pear"
    if [[ "$?" == 0 ]]; then
      log_success "dequeue apple from 'fruits'"
    else
      log_failure "dequeue should remove apple from fruits"
    fi

    queue dequeue fruits
    actual=$(queue peek fruits)

    assert_eq "peach" "$actual" "should be peach"
    if [[ "$?" == 0 ]]; then
      log_success "dequeue pear from 'fruits'"
    else
      log_failure "dequeue should remove pear from fruits"
    fi

    queue dequeue fruits
    actual=$(queue peek fruits)

    assert_eq "" "$actual" 'should be ""'
    if [[ "$?" == 0 ]]; then
      log_success "dequeue apple from 'fruits'"
    else
      log_failure "dequeue should remove apple from fruits"
    fi

    unset fruits
  }

  test_peek() {
    log_header "Test peek"

    queue create fruits
    queue enqueue fruits "apple"
    queue enqueue fruits "pear"
    queue enqueue fruits "peach"

    local actual

    actual=$(queue peek fruits)
    assert_eq 'apple' "$actual" 'should be apple'
    if [[ "$?" == 0 ]]; then
      log_success "peek element is apple"
    else
      log_failure "peek should retur apple"
    fi

    queue dequeue fruits
    actual=$(queue peek fruits)
    assert_eq 'pear' "$actual" 'should be pear'
    if [[ "$?" == 0 ]]; then
      log_success "peek element is pear"
    else
      log_failure "peek should retur pear"
    fi

    unset fruits
  }

  test_clear() {
    log_header "Test clear"

    local actual

    queue create fruits
    queue clear fruits
    actual=$(declare -p fruits)
    assert_eq "declare -a fruits" "$actual" "should be 'declare -a fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "clear clears an empty queue 'fruits'"
    else
      log_failure "clear should clear 'fruits'"
    fi

    queue create fruits
    queue enqueue fruits "apple"
    queue enqueue fruits "pear"
    queue clear fruits
    actual=$(declare -p fruits)
    assert_eq "declare -a fruits" "$actual" "should be 'declare -a fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "clear clears a non empty queue 'fruits'"
    else
      log_failure "clear should clear 'fruits'"
    fi

    unset fruits
  }

  test_destroy() {
    log_header "Test destroy"

    queue create fruits
    queue enqueue fruits "apple"
    queue destroy fruits

    [[ ${fruits} ]] && log_failure "fruits not destroyed"\
                    || log_success "fruits destroyed"

    unset fruits
  }

  # test calls

  test_create
  test_enqueue
  test_size
  test_empty
  test_dequeue
  test_peek
  test_clear
  test_destroy

)

test_queue
