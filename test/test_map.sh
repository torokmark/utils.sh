#!/usr/bin/env bash

#####################################################################
##
## description:
## Tests for the map extension
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
source "../lib/map.sh"

test_map()(
  log_header "Test map.sh"

  test_create() {
    log_header "Test create"

    local actual

    map create "fruits"
    actual=$(declare -p fruits)
    assert_eq "declare -A fruits" "$actual" "should be 'declare -A fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "create creates an empty map 'fruits'"
    else
      log_failure "create should return 'declare -A fruits'"
    fi

    unset fruits
  }

  test_add(){
    log_header "Test add"

    map create "fruits"
    map add "fruits" "apple" "1"
    local actual

    actual=$(map contains fruits apple)
    assert_eq "true" "$actual" 'should be true'
    if [[ "$?" == 0 ]]; then
      log_success "added apple to map 'fruits'"
    else
      log_failure "add should add apple to fruits"
    fi
  }

  test_get(){
    log_header "Test get"

    map create "fruits"
    map add "fruits" "apple" "3"
    map add "fruits" "pear" "5"
    local actual

    actual=$(map get fruits apple)
    assert_eq "3" "$actual" 'should be 3'
    if [[ "$?" == 0 ]]; then
      log_success "get apple value from map 'fruits':3"
    else
      log_failure "get should return 3"
    fi

    actual=$(map get fruits pear)
    assert_not_eq "3" "$actual" 'should be 5'
    if [[ "$?" == 0 ]]; then
      log_success "get pear value from map 'fruits' is not 3 but 5"
    else
      log_failure "get should return 5"
    fi
  }

  test_set(){
    log_header "Test set"

    map create "fruits"
    map add "fruits" "apple" "1"
    map set "fruits" "apple" "2"
    local actual

    actual=$(map get fruits apple)
    assert_eq "2" "$actual" 'should be 2'
    if [[ "$?" == 0 ]]; then
      log_success "apple set to 2, from 1"
    else
      log_failure "set should modify value to 2"
    fi
  }

  test_remove(){
    log_header "Test remove"

    map create "fruits"
    map add "fruits" "apple" "1"
    map add "fruits" "pear" "12"
    map add "fruits" "peach" "21"
    local actual


    actual=$(map contains fruits apple)
    assert_true "true" "$actual" 'should be true'
    if [[ "$?" == 0 ]]; then
      log_success "fruits contains apple before remove"
    else
      log_failure "fruits should contain apple"
    fi

    map remove fruits apple
    actual=$(map contains fruits apple)
    assert_false "false" "$actual" 'should be false'
    if [[ "$?" == 0 ]]; then
      log_success "fruits not contains apple after remove"
    else
      log_failure "fruits should not contain apple"
    fi

  }

  test_size() {
    log_header "Test size"

    map create "fruits"

    local actual

    actual=$(map size fruits)
    assert_eq '0' "$actual" 'should be 0'
    if [[ "$?" == 0 ]]; then
      log_success "fruits size is 0"
    else
      log_failure "size should return 0"
    fi

    map add "fruits" "apple" "1"
    map add "fruits" "pear" "12"
    map add "fruits" "peach" "21"

    actual=$(map size fruits)
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

    map create "fruits"
    local actual

    actual=$(map empty fruits)
    assert_eq 'true' "$actual" 'true'
    if [[ "$?" == 0 ]]; then
      log_success "fruits is empty"
    else
      log_failure "empty should return true"
    fi

    map add "fruits" "apple" "1"

    actual=$(map empty fruits)
    assert_eq 'false' "$actual" 'should be false'
    if [[ "$?" == 0 ]]; then
      log_success "fruits is not empty"
    else
      log_failure "empty should return false"
    fi

    map remove "fruits" "apple"

    actual=$(map empty fruits)
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

    map create "fruits"
    map clear "fruits"
    actual=$(declare -p fruits)
    assert_eq "declare -A fruits" "$actual" "should be 'declare -A fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "clear clears an empty map 'fruits'"
    else
      log_failure "clear should clear 'fruits'"
    fi

    map create "fruits"
    map add "fruits" "apple" "1"
    map add "fruits" "pear" "12"
    map add "fruits" "peach" "21"
    map clear "fruits"
    actual=$(declare -p fruits)
    assert_eq "declare -A fruits" "$actual" "should be 'declare -A fruits' "
    if [[ "$?" == 0 ]]; then
      log_success "clear clears a non empty map 'fruits'"
    else
      log_failure "clear should clear 'fruits'"
    fi

    unset fruits
  }

  test_keys(){
    log_header "Test keys"

    map create "fruits"
    map add "fruits" "apple" "1"
    map add "fruits" "pear" "12"
    map add "fruits" "peach" "21"
<<<<<<< HEAD
    local actual=true

    for i in apple pear peach; do
      if [[ $(map contains fruits $i) == "false" ]]; then
        actual="false"
      fi
    done

    assert_eq "true" "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "map 'fruits' keys are apple, pear, peach"
    else
      log_failure "map 'fruits' should contains keys apple, pear, peach"
    fi

    unset fruits
  }

  test_values(){
    log_header "Test values"

    map create "fruits"
    map add "fruits" "apple" "1"
    map add "fruits" "pear" "12"
    map add "fruits" "peach" "21"
    local actual="true"

    if [[ $(map get fruits apple) -ne '1' ]]; then
      actual="false"
    fi

    if [[ $(map get fruits pear) -ne '12' ]]; then
      actual="false"
    fi

    if [[ $(map get fruits peach) -ne '21' ]]; then
      actual="false"
    fi

    assert_eq true "$actual" 'should be true'

    if [[ "$?" == 0 ]]; then
      log_success "map 'fruits' contains apple=1, pear=12, peach=21"
    else
      log_failure "map 'fruits' should contain apple, pear, peach"
    fi

    unset fruits
=======
    local actual

    #for i in "$(map keys fruits)"; do
    #  echo $i
    #done
    actual=$( map keys fruits )
    #assert_eq "1 12 21" "$actual" 'should be 1 12 21'
    assert_eq "apple pear peach" "$actual" 'should be apple pear peach'
    if [[ "$?" == 0 ]]; then
      log_success "map 'fruits' contains apple, pear, peach keys"
    else
      log_failure "map should contains  apple, pear, peach keys"
    fi
>>>>>>> 0b9e42ebbaceef168ca41371f81ae0063b700dea
  }

  test_contains(){
    log_header "Test contains"

    map create "fruits"
    map add "fruits" "apple" "1"
    map add "fruits" "pear" "12"
    map add "fruits" "peach" "21"
    local actual

<<<<<<< HEAD
    for i in $(map keys fruits); do
      actual=$( map contains fruits "$i" )
      assert_true "true" "$actual" 'should be true'

      if [[ "$?" == 0 ]]; then
        log_success "map 'fruits' contains $i"
      else
        log_failure "map 'fruits' should contain $i"
      fi
    done
    unset fruits
=======
    assert_eq "true" "$actual" 'should be true'
    for i in
      if [[ "$?" == 0 ]]; then
        log_success "added apple to map 'fruits'"
      else
        log_failure "add should add apple to fruits"
      fi
>>>>>>> 0b9e42ebbaceef168ca41371f81ae0063b700dea
  }


  # test calls

  test_create
  test_add
  test_get
  test_set
  test_remove
  test_clear
  test_size
<<<<<<< HEAD
  test_keys
  test_values
=======
  #test_keys
  # test_values
>>>>>>> 0b9e42ebbaceef168ca41371f81ae0063b700dea
  test_contains
  test_empty

)

test_map
