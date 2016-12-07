#!/usr/bin/env bash

source "../console.sh"

assert_eq() {
  local expected="$1"
  local actual="$2"
  local msg

  if [ "$#" -ge 3 ]; then
    msg="$3"
  fi

  if [ "$expected" == "$actual" ]; then
    return 0
  else
    [ "${#msg}" -gt 0 ] && log_failure "$expected == $actual :: $msg" || true
    return 1
  fi
}

assert_not_eq() {
  local expected="$1"
  local actual="$2"
  local msg

  if [ "$#" -ge 3 ]; then
    msg="$3"
  fi

  if [ ! "$expected" == "$actual" ]; then
    return 0
  else
    [ "${#msg}" -gt 0 ] && log_failure "$expected != $actual :: $msg" || true
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

  declare -a expected=("${!1}")
  # echo "${expected[@]}"

  declare -a actual=("${!2}")
  # echo "${actual[@]}"

  local msg
  if [ "$#" -ge 3 ]; then
    msg="$3"
  fi

  if [ ! "${#expected[@]}" == "${#actual[@]}" ]; then
    [ "${#msg}" -gt 0 ] && log_failure "(${expected[*]}) != (${actual[*]}) :: $msg" || true
    return 1
  fi

  local i
  for (( i=1; i < ${#expected[@]} + 1; i+=1 )); do
    if [ ! "${expected[$i-1]}" == "${actual[$i-1]}" ]; then
      return 1
    fi
  done
  return 0
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
