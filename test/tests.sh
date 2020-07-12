#!/usr/bin/env bash

DIR_TESTS=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR_TESTS/test_aggregate.sh"
source "$DIR_TESTS/test_files.sh"
source "$DIR_TESTS/test_map.sh"
source "$DIR_TESTS/test_queue.sh"
source "$DIR_TESTS/test_random.sh"
source "$DIR_TESTS/test_stack.sh"
source "$DIR_TESTS/test_string.sh"
