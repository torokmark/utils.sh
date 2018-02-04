#!/usr/bin/env bash

#####################################################################
##
## title: Queue Extension
##
## description:
## Queue extension of shell (bash, ...)
##
## author: Mihaly Csokas
##
## date: 04. Feb. 2018
##
## license: MIT
##
#####################################################################

source "./console.sh"

queue() {
  local operation="$1"
  shift

  case "$operation" in

        create)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[create must be followed by one param]" && return 1

            queue_name="$1"
            declare -ga "$queue_name"

                ;;

        add)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[add must be followed by two params]" && return 1



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

            declare -n queue_name="$1"
            echo ${#queue_name[@]}

            ;;

        next)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[remove must be followed by two params]" && return 1



            ;;


        *)
            echo $"Usage: $0 { create | add "\
              " | remove | elements | clear "\
              "}"
            exit 1

  esac

}
