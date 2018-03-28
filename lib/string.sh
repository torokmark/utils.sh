#!/usr/bin/env bash

#####################################################################
##
## title: String Extension
##
## description:
## String extension of shell (bash, ...)
##   with well-known function for string manipulation
## Function list based on:
##   https://docs.oracle.com/javase/7/docs/api/java/lang/String.html
##   https://docs.python.org/2/library/string.html#string-functions
##
## author: Mihaly Csokas
##
## date: 07. Dec. 2017
##
## license: MIT
##
#####################################################################

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR/console.sh"

string() {
  local operation="$1"
  shift

  case "$operation" in

       capitalize)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1
            local str="$1"

            local retval
            retval="${str^}"

            echo "$retval"

            ;;

        ## pre-condition:
        ##   - number of params cannot be less than two
        ##
        ## params:
        ##   - str: string : the string we investigate
        ##   - pos: integer : the position in which the character sits
        ## return:
        ##   - retval: character : the character on the passed position
        char_at)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

            local str="$1"
            local pos="$2"  # pos must be >= 0

            if [[ "$pos" -lt 0 ]]; then
              pos=${#str}
            fi

            local retval
            retval=${str:pos:1}

            echo "$retval"

            ;;

        # like sort method
        # Apple pear < APple peAr
        compare_to)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

            local left right
            left="$1"
            right="$2"

            local retval

            if [[ "$left" < "$right" ]]; then
              retval=-1
            elif [[ "$left" == "$right" ]]; then
              retval=0
            elif [[ "$left" > "$right" ]]; then
              retval=1
            else
              log_failure "[Unhandled state]"
            fi

            echo "$retval"

            ;;

        compare_to_ignore_case)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

            local left right
            left="${1,,}"
            right="${2,,}"

            local retval

            if [[ "$left" < "$right" ]]; then
              retval=-1
            elif [[ "$left" == "$right" ]]; then
              retval=0
            else
              retval=1
            fi

            echo "$retval"

            ;;

        concat)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

            local left right
            left="$1"
            right="$2"

            local retval
            retval+="$left$right"

            echo "$retval"

            ;;

        contains)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

            local left right
            left="$1"
            right="$2"

            local retval
            retval=false

            if [[ "$left" == *"$right"* ]]; then
              retval=true
            fi

            echo "$retval"

            ;;

        count)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

            local str pattern
            str="$1"
            pattern="$2"

            local retval
            local char_str char_pat
            retval=0
            if [[ "${#pattern}" -le "${#str}" ]]; then
              for (( i=0; i<"${#str}"; i+=1 )); do
                for (( j=0; j<"${#pattern}"; j+=1 )); do
                  char_str="${str:$i+$j:1}"
                  char_pat="${pattern:$j:1}"
                  if [[ ! "$char_str" == "$char_pat" ]]; then
                    continue 2 # ugly mish-mashing! TODO: fix it
                  fi
                done
                (( retval+=1 ))
              done
            else
              retval=0
            fi

            echo "$retval"

            ;;

        ends_with)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

            local str pattern
            str="$1"
            pattern="$2"

            local retval

            if [[ "$str" == *"$pattern" ]]; then
              retval=true
            else
              retval=false
            fi

            echo "$retval"

            ;;

        equals)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

            local str pattern
            str="$1"
            pattern="$2"

            local retval

            if [[ "$str" == "$pattern" ]]; then
              retval=true
            else
              retval=false
            fi

            echo "$retval"

            ;;

        equals_ignore_case)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

            local str pattern
            str="${1,,}"
            pattern="${2,,}"

            local retval

            if [[ "$str" == "$pattern" ]]; then
              retval=true
            else
              retval=false
            fi

            echo "$retval"

            ;;

        ## Example:
        ##   index_of "apple" "p" -> 1
        ##   index_of "apple" "pl" -> 2
        ##   index_of "apple" "p" 2 -> 2
        index_of)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

            local str="$1"
            local sub_str="$2"
            local retval
            local temp

            temp=${str#*$sub_str}
            retval=$(( ${#str} - ${#sub_str} - ${#temp}))

            echo $retval

            ;;

        is_empty)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1

            local str
            str="$1"

            local retval
            retval=false

            if [[ -z "$str" ]]; then
              retval=true
            fi

            echo "$retval"

            ;;

        join_fields)
            [[ "$#" -lt 2 ]] && log_failure "[must be two or more params, where the separator between elements is the first param]" && return 1

            local separator retval
            separator="$1"
            retval="$2"
            shift
            shift
            for i; do retval="$retval$separator$i"; done

            echo "$retval"

            ;;

        ## Example:
        ##   last_index_of "apple" "p" -> 2
        ##   last_index_of "apple" "pl" -> 2
        ##   last_index_of "apple" "p" 2 -> 0
        last_index_of)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

            local str="$1"
            local sub_str="$2"
            local retval
            local temp

            temp=${str##*$sub_str}
            retval=$(( ${#str} - ${#sub_str} - ${#temp}))

            echo $retval

            ;;

        length)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1

            local str="$1"
            local retval

            retval="${#str}"

            echo "$retval"
            ;;

        ## Example:
        ##   replace "apple" "p" "c" -> accle
        ##   replace "apple" "pp" "c" -> acle
        replace)
            # pre-conditions:
            [[ "$#" -lt 3 ]] && log_failure "[must be three params]" && return 1

            local original_string string_to_replace string_to_replace_with retval
            original_string="$1"
            string_to_replace="$2"
            string_to_replace_with="$3"
            retval="${original_string/$string_to_replace/$string_to_replace_with}"

            echo "$retval"

            ;;

        replace_all)
            # pre-conditions:
            [[ "$#" -lt 3 ]] && log_failure "[must be three params]" && return 1

            local original_string string_to_replace_with retval
            original_string="$1"
            string_to_replace="$2"
            string_to_replace_with="$3"
            retval="${original_string//$string_to_replace/$string_to_replace_with}"

            echo "$retval"

            ;;



        ## Example:
        ##   -
        ##   -
        starts_with)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

            local str pattern retval
            str="$1"
            pattern="$2"
            retval=false

            [[ "$str" == "$pattern"* ]] && retval=true

            echo "$retval"

            ;;

        strip)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1

            local str strip_char

            str="$1"
            strip_char="$2"

            (
            shopt -s extglob
            str="${str##*($strip_char)}"
            str="${str%%*($strip_char)}"

            echo "${str}"
            )

            ;;

        ## Example:
        ##   begindex
        ##   begindex, endindex
        substring)
            # pre-conditions:
            [[ "$#" -lt 2 ]] && log_failure "[must be two or three params]" && return 1

            local str=$1
            local retval

            if [[  "$#" -eq 2 ]]; then
              if [[ "$2" -le ${#str} ]]; then
                retval=${str:$2}
              else
                log_failure "[begindex must be less than string length]" && return 1
              fi
            fi

            if [[  "$#" -eq 3 ]]; then
              if [[ "$2" -le $3 ]]; then
                local substring_length
                substring_length=$(( $3-$2 ))
                retval=${str:$2:$substring_length}
              else
                log_failure "[begindex must be less than or equal to endindex]" && return 1
              fi
            fi

            echo "$retval"

            ;;

        swapcase)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1

            local retval
            retval="${1~~}"

            echo "$retval"

            ;;

        title)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1
            local str=$1
            local alpha="[[:alpha:]]"
            local retval=$1

            for (( i=0; i<${#str}; i++ )); do
              if [[ ${str:$i:1} != $alpha &&  ${str:$(($i+1)):1} == $alpha ]]; then
                local char_to_upper_case
                char_to_upper_case=${str:$(($i+1)):1}
                retval="${retval:0:$(($i+1))}${char_to_upper_case^^}${str:$(($i+2))}"
              fi
            done
            retval="${retval[@]^}"
            echo "$retval"

            ;;

        to_lower_case)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1

            local retval
            retval="${1,,}"

            echo "$retval"

            ;;

        to_upper_case)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1

            local retval
            retval="${1^^}"

            echo "$retval"

            ;;

        trim)
            # pre-conditions:
            [[ "$#" -lt 1 ]] && log_failure "[must be one param]" && return 1

            (
            shopt -s extglob

            local str="$1"
            str="${str##*([[:space:]])}"
            str="${str%%*([[:space:]])}"

            echo "${str}"
            )

            ;;

        *)
            echo $"Usage: $0 { "\
                " capitalize | char_at | compare_to "\
                "| compare_to_ignore_case | concat "\
                "| contains | count | ends_with | equals "\
                "| equals_ignore_case | index_of "\
                "| is_empty | join_fields | last_index_of "\
                "| length | replace | replace_all "\
                "| replace_first | starts_with | strip | substring "\
                "| swapcase | title | to_lower_case "\
                "| to_upper_case | trim }"
            exit 1

esac

}
