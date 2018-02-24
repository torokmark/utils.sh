#!/usr/bin/env bash

#####################################################################
##
## title: Random Extension
##
## description:
## Random extension of shell (bash, ...)
##
##
##
## author: Mihaly Csokas
##
## date: 03. Feb. 2018
##
## license: MIT
##
#####################################################################


source "./console.sh"

random() {
  local operation="$1"
  shift

  case "$operation" in

        get)
            local params="$#"

            case "$params" in

                "1")
                    echo $(( $RANDOM % ( $1 + 1 ) ))
                    ;;

                "2")
                    echo $(( ( $RANDOM % ( $2 - $1 + 1 ) ) + $1 ))
                    ;;

                *)
                    echo $RANDOM
                    ;;
            esac
            ;;




        *)
            echo $"Usage: $0 { get }"
            exit 1

  esac

}
