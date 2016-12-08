#!/usr/bin/env bash

#####################################################################
##
## title: Console
##
## description:
## Better console output extension of shell (bash, ...)
##
## Function list based on:
##   - http://stackoverflow.com/questions/4332478/read-the-current-text-color-in-a-xterm/4332530#4332530
##   - https://natelandau.com/bash-scripting-utilities/
##   - http://tldp.org/LDP/abs/html/debugging.html#ASSERT
##
## author: Mark Torok
##
## date: 07. Dec. 2016
##
## license: MIT
##
#####################################################################


#BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
#LIME_YELLOW=$(tput setaf 190)
#POWDER_BLUE=$(tput setaf 153)
#BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
#CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
#BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BOLD=$(tput bold)
#BLINK=$(tput blink)
#REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

log_header() {
	printf "\n${BOLD}${MAGENTA}==========  %s  ==========${NORMAL}\n" "$@" >&2
}

log_success() {
	printf "${GREEN}✔ %s${NORMAL}\n" "$@" >&2
}

log_failure() {
	printf "${RED}✖ %s${NORMAL}\n" "$@" >&2
}

log_warning() {
	printf "${YELLOW}➜ %s${NORMAL}\n" "$@" >&2
}

log_info() {
	printf "${UNDERLINE}${WHITE}Info:${NORMAL}  ${WHITE}%s${NORMAL}\n" "$@" >&2
}

log_debug() {
	if [[ ! -z "$DEBUG" ]]; then
		printf "${RED}DEBUG :: %s${NORMAL}\n" "$@" >&2
	fi
}
