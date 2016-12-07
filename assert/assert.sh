#!/usr/bin/env bash

source "../console.sh"

assert_eq() {
  local expected="$1"
  local actual="$2"
  local MSG

  if [ "$#" -ge 3 ]; then
    MSG="$3"
  fi

  if [ "$expected" == "$actual" ]; then
    return 0
  else
    [ "${#MSG}" -gt 0 ] && log_failure "$MSG" || true
    return 1
  fi
}

assert_not_eq() {
  local expected="$1"
  local actual="$2"
  local MSG

  if [ "$#" -ge 3 ]; then
    MSG="$3"
  fi

  if [ ! "$expected" == "$actual" ]; then
    return 0
  else
    [ "${#MSG}" -gt 0 ] && log_failure "$MSG" || true
    return 1
  fi
}

assert_true() {
  local actual
  local msg

  actual="$1"

  if [ "$#" -ge 3 ]; then
    msg="$3"
  fi

  assert_eq true "$actual" "$msg"
  return "$?"
}

assert_false() {
  local actual
  local msg

  actual="$1"

  if [ "$#" -ge 3 ]; then
    msg="$3"
  fi

  assert_eq false "$actual" "$msg"
  return "$?"
}

assert_array_eq() {
  :
}

assert_array_not_eq() {
  :
}

assert_empty() {
  local actual
  local msg

  actual="$1"

  if [ "$#" -ge 3 ]; then
    msg="$3"
  fi

  assert_eq "" "$actual" "$msg"
  return "$?"
}

assert_not_empty() {
  local actual
  local msg

  actual="$1"

  if [ "$#" -ge 3 ]; then
    msg="$3"
  fi

  assert_not_eq "" "$actual" "$msg"
  return "$?"
}
