#!/usr/bin/env bash

#####################################################################
##
## description:
## Tests for the set extension
##
## author: Mihaly Csokas
##
## date: 19. feb. 2018
##
## license: MIT
##
#####################################################################

source "../lib/console.sh"
source "../vendor/assert.sh/assert.sh" # it also sources the console.sh
source "../lib/set.sh"

test_set()(
  log_header "Test set.sh"

  test_create() {
    log_header "Test create"

    local actual

    set_collection create "fruits"
    actual=$(declare -p fruits)
    assert_eq "declare -A fruits" "$actual" "should be 'declare -A fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "create creates an empty set_collection 'fruits'"
    else
      log_failure "create should return 'declare -A fruits'"
    fi

    unset fruits
  }

  test_add(){
    log_header "Test add"

    set_collection create "fruits"
<<<<<<< HEAD
    set_collection add "fruits" "apple"
=======
    set_collection add "fruits" "apple" "1"
>>>>>>> 4de7e9c9ea1c33ae9df8141488428652048cbfd2
    local actual

    actual=$(set_collection contains fruits apple)
    assert_eq "true" "$actual" 'should be true'
    if [[ "$?" == 0 ]]; then
      log_success "added apple to set_collection 'fruits'"
    else
      log_failure "add should add apple to fruits"
    fi
  }

  test_remove(){
    log_header "Test remove"

    set_collection create "fruits"
<<<<<<< HEAD
    set_collection add "fruits" "apple"
    set_collection add "fruits" "pear"
    set_collection add "fruits" "peach"
=======
    set_collection add "fruits" "apple" "1"
    set_collection add "fruits" "pear" "12"
    set_collection add "fruits" "peach" "21"
>>>>>>> 4de7e9c9ea1c33ae9df8141488428652048cbfd2
    local actual


    actual=$(set_collection contains fruits apple)
    assert_true "true" "$actual" 'should be true'
    if [[ "$?" == 0 ]]; then
      log_success "fruits contains apple before remove"
    else
      log_failure "fruits should contain apple"
    fi

    set_collection remove fruits apple
    actual=$(set_collection contains fruits apple)
    assert_false "false" "$actual" 'should be false'
    if [[ "$?" == 0 ]]; then
      log_success "fruits not contains apple after remove"
    else
      log_failure "fruits should not contain apple"
    fi

  }

  test_size() {
    log_header "Test size"

    set_collection create "fruits"

    local actual

    actual=$(set_collection size fruits)
    assert_eq '0' "$actual" 'should be 0'
    if [[ "$?" == 0 ]]; then
      log_success "fruits size is 0"
    else
      log_failure "size should return 0"
    fi

<<<<<<< HEAD
    set_collection add "fruits" "apple"
    set_collection add "fruits" "pear"
    set_collection add "fruits" "peach"
=======
    set_collection add "fruits" "apple" "1"
    set_collection add "fruits" "pear" "12"
    set_collection add "fruits" "peach" "21"
>>>>>>> 4de7e9c9ea1c33ae9df8141488428652048cbfd2

    actual=$(set_collection size fruits)
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

    set_collection create "fruits"
    local actual

    actual=$(set_collection empty fruits)
    assert_eq 'true' "$actual" 'true'
    if [[ "$?" == 0 ]]; then
      log_success "fruits is empty"
    else
      log_failure "empty should return true"
    fi

<<<<<<< HEAD
    set_collection add "fruits" "apple"
=======
    set_collection add "fruits" "apple" "1"
>>>>>>> 4de7e9c9ea1c33ae9df8141488428652048cbfd2

    actual=$(set_collection empty fruits)
    assert_eq 'false' "$actual" 'should be false'
    if [[ "$?" == 0 ]]; then
      log_success "fruits is not empty"
    else
      log_failure "empty should return false"
    fi

    set_collection remove "fruits" "apple"

    actual=$(set_collection empty fruits)
    assert_eq 'true' "$actual" 'should be true'
    if [[ "$?" == 0 ]]; then
      log_success "fruits after remove final element is empty"
    else
      log_failure "empty should return true"
    fi

    unset fruits
  }

  test_clear() {
    log_header "Test clear"

    local actual

    set_collection create "fruits"
    set_collection clear "fruits"
    actual=$(declare -p fruits)
    assert_eq "declare -A fruits" "$actual" "should be 'declare -A fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "clear clears an empty set_collection 'fruits'"
    else
      log_failure "clear should clear 'fruits'"
    fi

    set_collection create "fruits"
<<<<<<< HEAD
    set_collection add "fruits" "apple"
    set_collection add "fruits" "pear"
    set_collection add "fruits" "peach"
=======
    set_collection add "fruits" "apple" "1"
    set_collection add "fruits" "pear" "12"
    set_collection add "fruits" "peach" "21"
>>>>>>> 4de7e9c9ea1c33ae9df8141488428652048cbfd2
    set_collection clear "fruits"
    actual=$(declare -p fruits)
    assert_eq "declare -A fruits" "$actual" "should be 'declare -A fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "clear clears a non empty set_collection 'fruits'"
    else
      log_failure "clear should clear 'fruits'"
    fi

    unset fruits
  }

  test_union(){
    log_header "Test union"

    set_collection create "tropical"
    set_collection add "tropical" "banana"
    set_collection add "tropical" "guava"
    set_collection add "tropical" "lemon"

    set_collection create "exotic"
    set_collection add "exotic" "kiwi"
    set_collection add "exotic" "pummelo"
    set_collection add "exotic" "lychee"

    set_collection union tropical exotic fruits

    local actual=true

    for i in banana guava lemon kiwi pummelo lychee; do
      [[ $(set_collection contains fruits $i) == "false" ]] && actual="false"
    done

    [[ $(set_collection size fruits) -ne "6" ]] && actual="false"

    assert_eq "true" "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "set_collection 'fruits' elements are banana guava lemon kiwi pummelo lychee"
    else
      log_failure "set_collection 'fruits' should contains banana guava lemon kiwi pummelo lychee"
    fi

    unset tropical
    unset exotic
    unset fruits
  }

  test_intersection(){
    log_header "Test intersection"

    set_collection create "primes"
    set_collection add "primes" "2"
    set_collection add "primes" "3"
    set_collection add "primes" "5"

    set_collection create "evens"
    set_collection add "evens" "2"
    set_collection add "evens" "4"
    set_collection add "evens" "6"

    set_collection intersection primes evens intersec

    local actual=true

    [[ $(set_collection contains intersec "2" ) == "false" ]] && actual="false"
    [[ $(set_collection size intersec) -ne "1" ]] && actual="false"

    assert_eq "true" "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "set_collection 'intersec' elements are 2"
    else
      log_failure "set_collection 'intersec' should contains 2"
    fi

    unset primes
    unset evens
    unset intersec
  }

  test_difference(){
    log_header "Test difference"

    set_collection create "primes"
    set_collection add "primes" "2"
    set_collection add "primes" "3"
    set_collection add "primes" "5"

    set_collection create "evens"
    set_collection add "evens" "2"
    set_collection add "evens" "4"
    set_collection add "evens" "6"

    set_collection difference primes evens diff

    local actual=true

    for i in 3 5; do
      [[ $(set_collection contains diff $i) == "false" ]] && actual="false"
    done
    [[ $(set_collection size diff) -ne "2" ]] && actual="false"

    assert_eq "true" "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "set_collection 'diff' elements are 3, 5"
    else
      log_failure "set_collection 'diff' should contains 3, 5"
    fi

    unset primes
    unset evens
    unset diff
  }

  test_subset(){
    log_header "Test subset"

    set_collection create "primes"
    set_collection add "primes" "2"
    set_collection add "primes" "3"
    set_collection add "primes" "5"

    set_collection create "evens"
    set_collection add "evens" "2"
    set_collection add "evens" "4"
    set_collection add "evens" "6"
    set_collection add "evens" "8"

    set_collection create "evens1"
    set_collection add "evens1" "2"
    set_collection add "evens1" "4"
    set_collection add "evens1" "8"

    local actual=$(set_collection subset primes evens)

    assert_eq "false" "$actual" 'should be false'

    if [[ "$?" == 0 ]]; then
      log_success "set_collection 'primes' is not a subset of evens"
    else
      log_failure "set_collection 'primes' should not a subset of evens"
    fi

    local actual=$(set_collection subset evens1 evens)

    assert_eq "true" "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "$(set_collection elements evens1) is a subset of $(set_collection elements evens)"
    else
      log_failure "$(set_collection elements evens1) should be a subset of $(set_collection elements evens)"
    fi

    unset primes
    unset evens
    unset evens1

  }

  test_equal(){
    log_header "Test equal"

    set_collection create "primes"
    set_collection add "primes" "2"
    set_collection add "primes" "3"
    set_collection add "primes" "5"

    set_collection create "evens"
    set_collection add "evens" "2"
    set_collection add "evens" "4"
    set_collection add "evens" "6"


    set_collection create "evens1"
    set_collection add "evens1" "2"
    set_collection add "evens1" "4"
    set_collection add "evens1" "6"

    local actual=$(set_collection equal primes evens)

    assert_eq "false" "$actual" 'should be false'

    if [[ "$?" == 0 ]]; then
      log_success "$(set_collection elements primes) not equals $(set_collection elements evens)"
    else
      log_failure "set_collection 'primes' should not equals evens"
    fi

    local actual=$(set_collection equal evens1 evens)

    assert_eq "true" "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "$(set_collection elements evens1) equals $(set_collection elements evens)"
    else
      log_failure "'2, 4, 6' should be a subset of '2, 4, 6, 6'"
    fi

    unset primes
    unset evens
    unset evens1

  }

  test_elmenets(){
    log_header "Test elements"

    set_collection create "fruits"
    set_collection add "fruits" "apple"
    set_collection add "fruits" "pear"
    set_collection add "fruits" "peach"
    local actual=true

    for i in apple pear peach; do
      if [[ $(set_collection contains fruits $i) == "false" ]]; then
        actual="false"
      fi
    done

    assert_eq "true" "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "set_collection 'fruits' elements are apple, pear, peach"
    else
      log_failure "set_collection 'fruits' should contains apple, pear, peach"
    fi

    unset fruits
  }

  test_contains(){
    log_header "Test contains"

    set_collection create "fruits"
    set_collection add "fruits" "apple" "1"
    set_collection add "fruits" "pear" "12"
    set_collection add "fruits" "peach" "21"
    local actual

    for i in $(set_collection keys fruits); do
      actual=$( set_collection contains fruits "$i" )
      assert_true "true" "$actual" 'should be true'

      if [[ "$?" == 0 ]]; then
        log_success "set_collection 'fruits' contains $i"
      else
        log_failure "set_collection 'fruits' should contain $i"
      fi
    done
    unset fruits
  }

  # test calls

  test_create
  test_add
  test_remove
  test_elmenets
  test_clear
  test_size
  test_union
  test_intersection
  test_difference
  test_subset
  test_equal
  test_empty

)

test_set
