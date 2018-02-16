#!/usr/bin/env bash

#####################################################################
##
## title: Stack Extension
##
## description:
## Stack extension of shell (bash, ...)
##
## author: Mihaly Csokas
##
## date: 04. Feb. 2018
##
## license: MIT
##
#####################################################################

source "./console.sh"

stack() {
  local operation="$1"
  shift

  case "$operation" in

        create)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[create must be followed by one param]" && return 1

            stack_name="$1"
            declare -ga "$stack_name"

                ;;

        push)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[push must be followed by two params]" && return 1

            declare -n stack_name="$1"
            local value="$2"
            stack_name+=( "$value" )

            ;;

        clear)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[clear must be followed by one param]" && return 1

            unset $1
            declare -ga "$1"

            ;;

        size)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[size must be followed by one param]" && return 1

            declare -n stack_name="$1"
            echo "${#stack_name[@]}"

            ;;

        pop)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[pop must be followed by one param]" && return 1

            declare -n stack_name="$1"

            local last_index
            if [[ ${#stack_name[@]} -gt 0 ]]; then
              last_index=$(( ${#stack_name[@]} - 1 ))
              unset stack_name["$last_index"]
            fi

            ;;

        top)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[top must be followed by one param]" && return 1

            declare -n stack_name="$1"
            local retval
            if [[ ${#stack_name[@]} -gt 0 ]]; then
              local last_index=$(( ${#stack_name[@]} - 1 ))
              retval="${stack_name[$last_index]}"
            fi
            
            echo "$retval"
            ;;

        empty)

            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[empty must be followed by one param]" && return 1

            declare -n stack_name="$1"
            local size="${#stack_name[@]}"
            [[ $size -eq 0 ]] && echo "true" || echo "false"

            ;;

        *)
            echo $"Usage: $0 { create | push "\
              " | pop | top | clear "\
              " | empty }"
            exit 1

  esac

}
