#!/usr/bin/env bash

#####################################################################
##
## title: Decimal Extension
##
## description:
## Decimal extension of shell (bash)
##   for basic decimal caclulations in specified precision
##
## author: Mihaly Csokas
##
## date: 28. Jan. 2018
##
## license: MIT
##
#####################################################################

# source "./console.sh"
# #source "./string.sh"
#
# decimal() {
#
#   local operation="$1"
#   shift
#
#   case "$operation" in
#
#         addition)
#             # pre-conditions:
#             [[ "$#" -lt 2 ]] && log_failure "[addition must be followed by two params]" && return 1
#
#             local retval
#             local term1="$1"
#             local term2="$2"
#             local shorter
#             local longer
#
#             local term1_decimals=$( decimal_places $term1 )
#             local term2_decimals=$( decimal_places $term2 )
#
#             if (( $term1_decimals > $term2_decimals ))
#             then
#               shorter=$term2
#               longer=$term1
#             else
#               shorter=$term1
#               longer=$term2
#             fi
#             local difference
#             difference=$( decimal_places_difference $term1_decimals $term2_decimals )
#
#             local longer_decimal_places=$( more_decimal_places $term1 $term2 )
#             shorter=$( concat_zeros $shorter $difference )
#
#             shorter=${shorter//"."/""}
#             longer=${longer//"."/""}
#
#             local result=$(( $shorter + $longer ))
#             #retval=$((${IMG_WIDTH}00/$IMG2_WIDTH))
#             #echo "${RESULT:0:-2}.${RESULT: -2}"
#             retval=${result:0:-$longer_decimal_places}.${result: -$longer_decimal_places}
#             echo $retval
#             ;;
#
#         subtraction)
#             # pre-conditions:
#             [[ "$#" -lt 2 ]] && log_failure "[subtraction must be followed by two params]" && return 1
#
#             ;;
#
#         multiplication)
#             # pre-conditions:
#             [[ "$#" -lt 2 ]] && log_failure "[multiplication must be followed by two params]" && return 1
#
#             ;;
#
#         division)
#             # pre-conditions:
#             [[ "$#" -lt 3 ]] && log_failure "[division must be followed by three params]" && return 1
#
#             ;;
#
#         *)
#             echo $"Usage: $0 { addition | subtraction "\
#               "| multiplication | division }"
#             exit 1
#
#   esac
#
# }
#
# more_decimal_places(){
#   # pre-conditions:
#   [[ "$#" -lt 2 ]] && log_failure "[must be two params]" && return 1
#
#   local decimal_places
#   local first_decimal_places=${1##*"."}
#   local second_decimal_places=${2##*"."}
#
#   if (( ${#first_decimal_places} > ${#second_decimal_places} ))
#   then
#     decimal_places=${#first_decimal_places}
#   else
#     decimal_places=${#second_decimal_places}
#   fi
#
#   echo "$decimal_places"
# }
#
# decimal_places(){
#   # pre-conditions:
#   [[ "$#" -lt 1 ]] && log_failure "[must be followed by one param]" && return 1
#
#   local decimal_places=${1##*"."}
#
#   echo "${#decimal_places}"
# }
#
# decimal_places_difference(){
#   # pre-conditions:
#   [[ "$#" -lt 1 ]] && log_failure "[must be two params]" && return 1
#
#   local tmp1=$1
#   local tmp2=$2
#   local retval
#   if (( $tmp1 > $tmp2 ))
#   then
#     retval=$(( $tmp1-$tmp2 ))
#   else
#     retval=$(( $tmp2-$tmp1 ))
#   fi
#
#   echo "$retval"
# }
#
# concat_zeros(){
#   # pre-conditions:
#   [[ "$#" -lt 1 ]] && log_failure "[must be two params]" && return 1
#
#   local retval=$1
#
#   for (( c=0; c<$2; c++ ))
#   do
#    retval="$retval""0"
#   done
#
#   echo "$retval"
# }
