#!/usr/bin/env bash

#####################################################################
##
## title: Date and Time
##
## description:
## Date, time functions
##
## author: Mihaly Csokas
##
## date: 06. Dec. 2017
##
## license: MIT
##
#####################################################################

source "./console.sh"

datetime() (
  local function_name="$1"

  #       %T     The time in 24-hour notation (%H:%M:%S).  (SU)
  current_time() {

    local retval
    retval=$( printf "%(%T)T" -1 )

    echo "$retval"
  }

  #       %b     The abbreviated month name according to the current locale.
  month_name() {

    local retval
    retval=$( printf "%(%B)T" -1 )

    echo "$retval"
  }

  #       %A     The full name of the day of the week according to the current
  #              locale.
  name_of_day() {

    local retval
    retval=$( printf "%(%A)T" -1 )

    echo "$retval"
  }

  #       %C     The century number (year/100) as a 2-digit integer. (SU)
  century() {

    local retval
    retval=$( printf "%(%C)T" -1 )

    echo "$retval"
  }

  #       %d     The day of the month as a decimal number (range 01 to 31).
  day_of_month() {

    local retval
    retval=$( printf "%(%d)T" -1 )

    echo "$retval"
  }

  #       %H     The hour as a decimal number using a 24-hour clock (range 00
  #              to 23).
  hour() {

    local retval
    retval=$( printf "%(%H)T" -1 )

    echo "$retval"
  }

  #       %F     Equivalent to %Y-%m-%d (the ISO 8601 date format). (C99)
  date() {

    local retval
    retval=$( printf "%(%F)T" -1 )

    echo "$retval"
  }

  datetime() {

    local retval
    retval="$( printf "%(%F)T" -1 )"_"$( printf "%(%T)T" -1 )"

    echo "$retval"
  }

  #       %j     The day of the year as a decimal number (range 001 to 366).
  day_of_year() {

    local retval
    retval=$( printf "%(%j)T" -1 )

    echo "$retval"
  }

  #       %m     The month as a decimal number (range 01 to 12).
  month() {

    local retval
    retval=$( printf "%(%m)T" -1 )

    echo "$retval"
  }

  #       %M     The minute as a decimal number (range 00 to 59).
  minute() {

    local retval
    retval=$( printf "%(%m)T" -1 )

    echo "$retval"
  }

  #       %s     The number of seconds since the Epoch, 1970-01-01 00:00:00
  #              +0000 (UTC).
  seconds_since_epoch() {

    local retval
    retval=$( printf "%(%s)T" -1 )

    echo "$retval"
  }

  #       %S     The second as a decimal number (range 00 to 60).  (The range
  #              is up to 60 to allow for occasional leap seconds.)
  second() {

    local retval
    retval=$( printf "%(%S)T" -1 )

    echo "$retval"
  }

  #       %u     The day of the week as a decimal, range 1 to 7, Monday being
  #              1.
  day_of_week() {

    local retval
    retval=$( printf "%(%u)T" -1 )

    echo "$retval"
  }

  #       %W     The week number of the current year as a decimal number, range
  #              00 to 53, starting with the first Monday as the first day of
  #              week 01.
  week_of_year() {

    local retval
    retval=$( printf "%(%W)T" -1 )

    echo "$retval"
  }

  #       %Y     The year as a decimal number including the century.
  year() {

    local retval
    retval=$( printf "%(%Y)T" -1 )

    echo "$retval"
  }

  case "$function_name" in
        current_time)
            current_time
            ;;

        date)
            date
            ;;

        month_name)
            month_name
            ;;

        name_of_day)
            name_of_day
            ;;

        century)
            century
            ;;

        day_of_month)
            day_of_month
            ;;

        day_of_year)
            day_of_year
            ;;

        month)
            month
            ;;

        minute)
            minute
            ;;

        seconds_since_epoch)
            seconds_since_epoch
            ;;

        second)
            second
            ;;

        day_of_week)
            day_of_week
            ;;

        week_of_year)
            week_of_year
            ;;

        year)
            year
            ;;

        "")
            datetime
            ;;

        *)
            echo $"Usage: $0 {current_time | month_name"\
              "| name_of_day | century | day_of_month"\
              "| hour | date | day_of_year | month"\
              "| minute | seconds_since_epoch| second"\
              "| day_of_week | week_of_year | year"\
              "| datetime}"
            exit 1

  esac

)
