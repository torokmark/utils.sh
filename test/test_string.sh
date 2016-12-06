#!/usr/bin/env bash

source "../lib//string.sh"

test_char_at() {
	local actual
	actual=$( char_at "apple" "3" )
	# assert_eq "$expected" "$actual" "returns 'l'"
	echo "$actual"
}

main() {
	test_char_at
}

main
