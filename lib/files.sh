#!/usr/bin/env bash

#####################################################################
##
## title: File Extension 
##
## description:
## File extension of shell (bash)
##   with helpful functions for file manipulations 
##
## Preconditions:
##   bash 4.3+
##
## author: Mark Torok
##
## date: 06. July 2020.
##
## license: MIT
##
#####################################################################

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR/console.sh"

files() {
  local operation="$1"
  shift

  case "$operation" in
    is_file)
        [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1
        local filepath="$1"

        if [ -f "$filepath" ]; then
            echo 0
        else
            echo 1
        fi
        ;;
    is_dir)
        [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1
        local dirpath="$1"

        if [ -d "$dirpath" ]; then
            echo 0
        else
            echo 1
        fi
        ;;
    exist)
        [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1
        local path="$1"

        if [ -e "$path" ]; then
            echo 0
        else
            echo 1
        fi
        ;;
    is_symlink)
        [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1
        local filepath="$1"

        if [ -L "$filepath" ]; then
            echo 0
        else
            echo 1
        fi
        ;;
    is_socket)
        [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1
        local path="$1"

        if [ -S "$path" ]; then
            echo 0
        else
            echo 1
        fi
        ;;
    is_readable)
        [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1
        local path="$1"

        if [ -r "$path" ]; then
            echo 0
        else
            echo 1
        fi
        ;;
    is_writable)
        [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1
        local path="$1"

        if [ -w "$path" ]; then
            echo 0
        else
            echo 1
        fi
        ;;
    is_executable)
        [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1
        local path="$1"

        if [ -x "$path" ]; then
            echo 0
        else
            echo 1
        fi
        ;;
    *)
        echo $"Usage: $0 { "\
            " is_file | is_dir | exist "\
            "| is_symlink | is_socket "\
            "| is_readable | is_writable | is_executable }"
        exit 1


  esac
}
