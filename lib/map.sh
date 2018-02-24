#!/usr/bin/env bash

#####################################################################
##
## title: Map Extension
##
## description:
## Map extension of shell (bash)
##   with well-known function for map manipulation
##
## Preconditions:
##   bash 4.3+
##
## author: Mihaly Csokas
##
## date: 25. Dec. 2017
##
## license: MIT
##
#####################################################################

source "./console.sh"

map() {
  local operation="$1"
  shift

  case "$operation" in

        create)
            # pre-conditions:
            #[[ "$#" -lt 1 ]] && log_failure "[create must be followed by one param]" && return 1
            [[ "$#" -ne 1 ]] && log_failure "[create must be followed by one param]" && return 1

            map_name="$1"
            declare -gA "$map_name"
            ;;

        add)
            # pre-conditions:
            #[[ "$#" -lt 2 ]] && log_failure "[add must be followed by three params]" && return 1
            [[ "$#" -ne 3 ]] && log_failure "[add must be followed by three params]" && return 1

            declare -n map_name="$1"
            local key="$2"
            local value="$3"
            map_name+=( ["$key"]="$value" )

            ;;

        clear)
            # pre-conditions:
            #[[ "$#" -lt 1 ]] && log_failure "[clear must be followed by one param]" && return 1
            [[ "$#" -ne 1 ]] && log_failure "[clear must be followed by one param]" && return 1

            unset $1
            declare -gA "$1"

            ;;

        size)
            # pre-conditions:
            #[[ "$#" -lt 1 ]] && log_failure "[size must be followed by one param]" && return 1
            [[ "$#" -ne 1 ]] && log_failure "[size must be followed by one param]" && return 1

            declare -n map_name="$1"
            echo ${#map_name[@]}

            ;;

        remove)
            # pre-conditions:
            #[[ "$#" -lt 2 ]] && log_failure "[remove must be followed by two params]" && return 1
            [[ "$#" -ne 2 ]] && log_failure "[remove must be followed by two params]" && return 1

            declare -n map_name="$1"
            local key="$2"
            unset map_name["$key"]

            ;;


        get)
            # pre-conditions:
            #[[ "$#" -lt 2 ]] && log_failure "[get must be followed by two params]" && return 1
            [[ "$#" -ne 2 ]] && log_failure "[get must be followed by two params]" && return 1

            declare -n map_name="$1"
            local key="$2"
            echo ${map_name["$key"]}

            ;;

        set)
            # pre-conditions:
            #[[ "$#" -lt 3 ]] && log_failure "[set must be followed by three params]" && return 1
            [[ "$#" -ne 3 ]] && log_failure "[set must be followed by three params]" && return 1

            declare -n map_name="$1"
            local key="$2"
            local value="$3"
            map_name["$key"]="$3"

            ;;

        keys)
            # pre-conditions:
            #[[ "$#" -lt 1 ]] && log_failure "[keys must be followed by one param]" && return 1
            [[ "$#" -ne 1 ]] && log_failure "[keys must be followed by one param]" && return 1

            declare -n map_name="$1"
            echo ${!map_name[@]}

            ;;

        values)
            # pre-conditions:
            #[[ "$#" -lt 1 ]] && log_failure "[values must be followed by one param]" && return 1
            [[ "$#" -ne 1 ]] && log_failure "[values must be followed by one param]" && return 1

            declare -n map_name="$1"
            echo ${map_name[@]}

            ;;

        contains)
            # pre-conditions:
            #[[ "$#" -lt 2 ]] && log_failure "[contains must be followed by two params]" && return 1
            [[ "$#" -ne 2 ]] && log_failure "[contains must be followed by two params]" && return 1

            declare -n map_name="$1"
            local element="$2"
            local retval="false"

            for i in "${!map_name[@]}"
            do
              if [[ "$i" = "$element" ]]; then
                retval="true"
              fi
            done


            echo ${retval}

            ;;

        empty)

            # pre-conditions:
            #[[ "$#" -lt 1 ]] && log_failure "[empty must be followed by one param]" && return 1
            [[ "$#" -ne 1 ]] && log_failure "[empty must be followed by one param]" && return 1

            declare -n map_name="$1"
            local size="${#map_name[@]}"
            [[ $size -eq 0 ]] && echo "true" || echo "false"

            ;;

        *)
            echo $"Usage: $0 { create | add "\
              "| remove | keys | values "\
              "| clear | size | get "\
              "| set | contains | empty }"
            exit 1

  esac

}
