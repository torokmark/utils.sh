#!/usr/bin/env bash

#####################################################################
##
## description:
## Tests for the aggregate extension
##
## author: Mihaly Csokas
##
## date: 19. feb. 2018
##
## license: MIT
##
#####################################################################

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR/../lib/console.sh"
source "$DIR/../vendor/assert.sh/assert.sh"
source "$DIR/../lib/aggregate.sh"

test_aggregate()(
  log_header "Test aggregate.sh"

  test_create() {
    log_header "Test create"

    local actual

    aggregate create fruits
    actual=$(declare -p fruits)
    assert_eq "declare -A fruits" "$actual" "should be 'declare -A fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "create creates an empty aggregate 'fruits'"
    else
      log_failure "create should return 'declare -A fruits'"
    fi

    unset fruits
  }

  test_add(){
    log_header "Test add"

    aggregate create fruits
    aggregate add fruits "apple"
    local actual

    actual=$(aggregate contains fruits apple)
    assert_eq "true" "$actual" 'should be true'
    if [[ "$?" == 0 ]]; then
      log_success "added apple to aggregate 'fruits'"
    else
      log_failure "add should add apple to fruits"
    fi
  }

  test_remove(){
    log_header "Test remove"

    aggregate create fruits
    aggregate add fruits "apple"
    aggregate add fruits "pear"
    aggregate add fruits "peach"
    local actual


    actual=$(aggregate contains fruits apple)
    assert_true "true" "$actual" 'should be true'
    if [[ "$?" == 0 ]]; then
      log_success "fruits contains apple before remove"
    else
      log_failure "fruits should contain apple"
    fi

    aggregate remove fruits apple
    actual=$(aggregate contains fruits apple)
    assert_false "false" "$actual" 'should be false'
    if [[ "$?" == 0 ]]; then
      log_success "fruits not contains apple after remove"
    else
      log_failure "fruits should not contain apple"
    fi

  }

  test_size() {
    log_header "Test size"

    aggregate create fruits

    local actual

    actual=$(aggregate size fruits)
    assert_eq '0' "$actual" 'should be 0'
    if [[ "$?" == 0 ]]; then
      log_success "fruits size is 0"
    else
      log_failure "size should return 0"
    fi

    aggregate add fruits "apple"
    aggregate add fruits "pear"
    aggregate add fruits "peach"

    actual=$(aggregate size fruits)
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

    aggregate create fruits
    local actual

    actual=$(aggregate empty fruits)
    assert_eq 'true' "$actual" 'true'
    if [[ "$?" == 0 ]]; then
      log_success "fruits is empty"
    else
      log_failure "empty should return true"
    fi

    aggregate add fruits "apple"

    actual=$(aggregate empty fruits)
    assert_eq 'false' "$actual" 'should be false'
    if [[ "$?" == 0 ]]; then
      log_success "fruits is not empty"
    else
      log_failure "empty should return false"
    fi

    aggregate remove fruits "apple"

    actual=$(aggregate empty fruits)
    assert_eq 'true' "$actual" 'should be true'
    if [[ "$?" == 0 ]]; then
      log_success "fruits after remove final element is empty"
    else
      log_failure "empty should return true"
    fi

    unset fruits
  }

  test_erase() {
    log_header "Test erase"

    local actual

    aggregate create fruits
    aggregate erase fruits
    actual=$(declare -p fruits)
    assert_eq "declare -A fruits" "$actual" "should be 'declare -A fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "erase clears an empty aggregate 'fruits'"
    else
      log_failure "erase should clear 'fruits'"
    fi

    aggregate create fruits
    aggregate add fruits "apple"
    aggregate add fruits "pear"
    aggregate add fruits "peach"
    aggregate erase fruits
    actual=$(declare -p fruits)
    assert_eq "declare -A fruits" "$actual" "should be 'declare -A fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "erase clears a non empty aggregate 'fruits'"
    else
      log_failure "erase should clear 'fruits'"
    fi

    unset fruits
  }

  test_union(){
    log_header "Test union"

    aggregate create tropical
    aggregate add tropical "banana"
    aggregate add tropical "guava"
    aggregate add tropical "lemon"

    aggregate create exotic
    aggregate add exotic "kiwi"
    aggregate add exotic "pummelo"
    aggregate add exotic "lychee"

    aggregate union tropical exotic fruits

    local actual=true

    for i in banana guava lemon kiwi pummelo lychee; do
      [[ $(aggregate contains fruits $i) == "false" ]] && actual="false"
    done

    [[ $(aggregate size fruits) -ne "6" ]] && actual="false"

    assert_eq "true" "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "aggregate 'fruits' elements are banana guava lemon kiwi pummelo lychee"
    else
      log_failure "aggregate 'fruits' should contains banana guava lemon kiwi pummelo lychee"
    fi

    unset tropical
    unset exotic
    unset fruits
  }

  test_intersection(){
    log_header "Test intersection"

    aggregate create primes
    aggregate add primes "2"
    aggregate add primes "3"
    aggregate add primes "5"

    aggregate create evens
    aggregate add evens "2"
    aggregate add evens "4"
    aggregate add evens "6"

    aggregate intersection primes evens intersec

    local actual=true

    [[ $(aggregate contains intersec "2" ) == "false" ]] && actual="false"
    [[ $(aggregate size intersec) -ne "1" ]] && actual="false"

    assert_eq "true" "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "aggregate 'intersec' elements are 2"
    else
      log_failure "aggregate 'intersec' should contains 2"
    fi

    unset primes
    unset evens
    unset intersec
  }

  test_difference(){
    log_header "Test difference"

    aggregate create primes
    aggregate add primes "2"
    aggregate add primes "3"
    aggregate add primes "5"

    aggregate create evens
    aggregate add evens "2"
    aggregate add evens "4"
    aggregate add evens "6"

    aggregate difference primes evens diff

    local actual=true

    for i in 3 5; do
      [[ $(aggregate contains diff $i) == "false" ]] && actual="false"
    done
    [[ $(aggregate size diff) -ne "2" ]] && actual="false"

    assert_eq "true" "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "aggregate 'diff' elements are 3, 5"
    else
      log_failure "aggregate 'diff' should contains 3, 5"
    fi

    unset primes
    unset evens
    unset diff
  }

  test_subset(){
    log_header "Test subset"

    aggregate create primes
    aggregate add primes "2"
    aggregate add primes "3"
    aggregate add primes "5"

    aggregate create evens
    aggregate add evens "2"
    aggregate add evens "4"
    aggregate add evens "6"
    aggregate add evens "8"

    aggregate create evens1
    aggregate add evens1 "2"
    aggregate add evens1 "4"
    aggregate add evens1 "8"

    local actual=$(aggregate subset primes evens)

    assert_eq "false" "$actual" 'should be false'

    if [[ "$?" == 0 ]]; then
      log_success "aggregate 'primes' is not a subset of evens"
    else
      log_failure "aggregate 'primes' should not a subset of evens"
    fi

    local actual=$(aggregate subset evens1 evens)

    assert_eq "true" "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "$(aggregate elements evens1) is a subset of $(aggregate elements evens)"
    else
      log_failure "$(aggregate elements evens1) should be a subset of $(aggregate elements evens)"
    fi

    unset primes
    unset evens
    unset evens1

  }

  test_equal(){
    log_header "Test equal"

    aggregate create primes
    aggregate add primes "2"
    aggregate add primes "3"
    aggregate add primes "5"

    aggregate create evens
    aggregate add evens "2"
    aggregate add evens "4"
    aggregate add evens "6"


    aggregate create evens1
    aggregate add evens1 "2"
    aggregate add evens1 "4"
    aggregate add evens1 "6"

    local actual=$(aggregate equal primes evens)

    assert_eq "false" "$actual" 'should be false'

    if [[ "$?" == 0 ]]; then
      log_success "$(aggregate elements primes) not equals $(aggregate elements evens)"
    else
      log_failure "aggregate 'primes' should not equals evens"
    fi

    local actual=$(aggregate equal evens1 evens)

    assert_eq "true" "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "$(aggregate elements evens1) equals $(aggregate elements evens)"
    else
      log_failure "'2, 4, 6' should be a subset of '2, 4, 6, 6'"
    fi

    unset primes
    unset evens
    unset evens1

  }

  test_elmenets(){
    log_header "Test elements"

    aggregate create fruits
    aggregate add fruits "apple"
    aggregate add fruits "pear"
    aggregate add fruits "peach"
    local actual=true

    for i in apple pear peach; do
      if [[ $(aggregate contains fruits $i) == "false" ]]; then
        actual="false"
      fi
    done

    assert_eq "true" "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "aggregate 'fruits' elements are apple, pear, peach"
    else
      log_failure "aggregate 'fruits' should contains apple, pear, peach"
    fi

    unset fruits
  }

  test_contains(){
    log_header "Test contains"

    aggregate create fruits
    aggregate add fruits "apple" "1"
    aggregate add fruits "pear" "12"
    aggregate add fruits "peach" "21"
    local actual

    for i in $(aggregate keys fruits); do
      actual=$( aggregate contains fruits "$i" )
      assert_true "true" "$actual" 'should be true'

      if [[ "$?" == 0 ]]; then
        log_success "aggregate 'fruits' contains $i"
      else
        log_failure "aggregate 'fruits' should contain $i"
      fi
    done
    unset fruits
  }

  test_destroy() {
    log_header "Test destroy"

    aggregate create fruits
    aggregate add fruits "apple"
    aggregate destroy fruits

    [[ ${fruits} ]] && log_failure "fruits not destroyed"\
                    || log_success "fruits destroyed"

    unset fruits
  }


  # test calls

  test_create
  test_add
  test_remove
  test_elmenets
  test_erase
  test_size
  test_union
  test_intersection
  test_difference
  test_subset
  test_equal
  test_empty
  test_destroy

)

test_aggregate
