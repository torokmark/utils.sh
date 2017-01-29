#!/usr/bin/env bash

#####################################################################
##
## title: Import.sh
##
## description:
##  Sourcing shell scripts locally is easy. But sourcing scripts
##  from remote does not work.
##  With import.sh we can easily source remote scripts from git repositories
##  or ftp servers.
##
##
## author: Mark Torok
##
## date: 11. Dec. 2016
##
## license: MIT
##
#####################################################################

## console.sh
## /etc/lib/*
## /etc/lib/**
## https://github.com/torokmark/shell_utils.git
## git://...
param_processor() {
  local path="$1"

  local retval

  if [[ "$path" == "http:"* || "$path" == "https:"* ]] && [[ "$path" == *".sh" ]]; then
    retval="http"
  elif [[ "$path" == "ftp:"* ]]; then
    retval="ftp"
  elif [[ "$path" == *".git" ]]; then
    retval="git"
  elif [[ "$path" == *"/**" ]]; then
    retval="directory_recursively"
  elif [[ "$path" == *"/*" ]]; then
    retval="directory"
  elif [[ "$path" == *".sh" ]]; then
    retval="shell"
  else
    retval="error"
  fi

  echo "$retval"
}

import_shell() {
  local path="$1"

  source "$path"
}

import_directory() {
  local path="$1"
  local location=
  location="${path%/*}"

  for f in `find "$location" -maxdepth 1 -type f -name "*.sh"`; do
    source "$f"
  done
}

import_directory_recursively() {
  local path="$1"
  local location=
  location="${path%/*}"

  for f in `find "$location" -type f -name "*.sh"`; do
    source "$f"
  done
}

import_git() {
  :
}

import_ftp() {
  :
}

import_http() {
  :
}


import() {
  [[ "$#" -lt 1 ]] && printf "[One param is required: Path]" && return 1

  local path="$1"

  local type
  type=$( param_processor "$path" )

  case "$type" in
    "shell")
      import_shell "$path"
      ;;
    "directory")
      import_directory "$path"
      ;;
    "directory_recursively")
      import_directory_recursively "$path"
      ;;
    "git")
      import_git "$path"
      ;;
    "ftp")
      import_ftp "$path"
      ;;
    "http")
      import_http "$path"
      ;;
    "error")
      printf "error: not valid path"
      ;;
    *)
      ;;
  esac

}
