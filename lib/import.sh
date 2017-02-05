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

sourced="$_"

## console.sh
## /etc/lib/*
## /etc/lib/**
## https://github.com/torokmark/shell_utils.git
## git://...
param_processor() {
  local path="$1"

  local retval=

  if [[ "$path" == "http:"* || "$path" == "https:"* ]] && [[ "$path" == *".sh" ]]; then
    retval="http"
  elif [[ "$path" == "ftp:"* || "$path" == "ftps:"* ]] && [[ "$path" == *".sh" ]]; then
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

check_and_create_project_dir() {
  local folder="$1"

  if [[ ! -d "$PROJECT_HOME/.dir/$folder" ]]; then
    mkdir -p "$PROJECT_HOME/.dir/$folder"
  fi
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
  local url="$1"
  local script_name=
  script_name="${url##*/}"

  if [[ ! "${#script_name}" == 0 ]]; then
    script_name="$PROJECT_HOME/.dir/ftp/$script_name"

    check_and_create_project_dir "ftp"
    curl -so "$script_name" "$url"

    source "$script_name"
  else
    echo "Script not found!"
  fi
}

import_http() {
  local url="$1"
  local script_name=
  script_name="${url##*/}"

  if [[ ! "${#script_name}" == 0 ]]; then
    script_name="$PROJECT_HOME/.dir/http/$script_name"

    check_and_create_project_dir "http"
    curl -so "$script_name" "$url"

    source "$script_name"
  else
    echo "Script not found!"
  fi
}

import_relative() {
  [[ "$#" -lt 1 ]] && printf "[One param is required: Path]" && return 1

  local path="$1"
  local source_path

  #[[ $called != $0 ]] && echo "Script is being sourced" || echo "Script is being run"
  #echo "\$BASH_SOURCE ${BASH_SOURCE[@]}"

  #echo "param : $path"
  source_path="$( readlink -f ${BASH_SOURCE[1]} )"

  #echo "source_path :: $source_path"
  #echo "BASH_SOURCE :: ${BASH_SOURCE[1]}"
  source "${source_path%/*}/$path"

}


import() {
  [[ "$#" -lt 1 ]] && printf "[One param is required: Path]" && return 1

  local path="$1"

  local type=
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
