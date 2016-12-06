#!/usr/bin/env bash

assert_eq() {
	local EXPECTED="$1"
	local ACTUAL="$2"
	local MSG

	if [ "$#" -eq 3 ]; then
		MSG="$3"
	fi


}
