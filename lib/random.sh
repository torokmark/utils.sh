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
  local params="$#"

      case "$params" in

        "1")
          echo $(( $RANDOM % ( $1 + 1 ) ))
          ;;

        "2")
          echo $(( ( $RANDOM % ( $2 - $1 + 1 ) ) + $1 ))
          ;;

        "0")
          echo $RANDOM
          ;;

        *)
          echo $"Usage: $0 [<param1> [<param2>]]"
          exit 1

      esac
            
}
