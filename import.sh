#!/usr/bin/env bash


set -e

import() {
	local PATH="$1"
	source "$PATH"
}

: '
test_import() {
	import "/etc/bash.bashrc"
	if [[ $? == 0 ]]; then
		echo "Successfully sourced" >&2
	fi

	import "something_not_exists" || true
	if [[ ! "$?" == 0 ]]; then
		echo "Failed to source" >&2; exit 1
	fi
}

# test_import
 '

set +e
