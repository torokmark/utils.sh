#!/usr/bin/env bash

#####################################################################
##
## description:
## Tests for the random extension
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
source "$DIR/../lib/files.sh"
source "$DIR/../lib/random.sh"

test_random()(
  log_header "Test random.sh"

  test() {
    log_header "Test random"

    for i in {1..5}; do
      local between
      local actual=$(random 10)
      [[ $actual -le 10 ]] && between=true
      [[ $actual -gt 10 ]] && between=false

      assert_eq "true" "$between" "$actual is between 0 and 10"
      if [[ "$?" == 0 ]]; then
        log_success "$actual is between 0 and 10"
      else
        log_failure "$actual should be between 0 and 10"
      fi
    done

    for i in {1..5}; do
      local between
      local actual=$(random 20 30)
      [[ $actual -le 30 ]] || [[ $actual -ge 20 ]] && between=true
      [[ $actual -gt 30 ]] || [[ $actual -lt 20 ]] && between=false

      assert_eq "true" "$between" "$actual is between 20 and 30"
      if [[ "$?" == 0 ]]; then
        log_success "$actual is between 20 and 30"
      else
        log_failure "$actual should be between 20 and 30"
      fi
    done

  }

  # test calls

  test

)

test_random
