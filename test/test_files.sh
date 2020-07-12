#!/usr/bin/env bash

#####################################################################
##
## description:
## Tests for the files extension
##
## author: Mark Torok 
##
## date: 08. July 2020.
##
## license: MIT
##
#####################################################################

source "../lib/console.sh"
source "../vendor/assert.sh/assert.sh"
source "../lib/files.sh"

test_files() {
  log_header "Test files.sh"

  test_is_file() {
    log_header "Test is_file"

    local actual

    actual=$( files is_file "test_files.sh" )
    assert_eq 0 "$actual" "is_file should return true (0) if file exists"
    if [[ "$?" == 0 ]]; then
      log_success "is_file returns true (0)"
    else
      log_failure "is_file should return true (0)"
    fi

    actual=$( files is_file "something" )
    assert_eq 1 "$actual" "is_file should return false (1) if file not exists"
    if [[ "$?" == 0 ]]; then
      log_success "is_file returns false (1)"
    else
      log_failure "is_file should return false (1)"
    fi

    actual=$( files is_file "/usr/bin" )
    assert_eq 1 "$actual" "is_file should return false (1) if file is dir"
    if [[ "$?" == 0 ]]; then
      log_success "is_file returns false (1)"
    else
      log_failure "is_file should return false (1)"
    fi
  }

  test_is_dir() {
    log_header "Test is_dir"

    local actual

    actual=$( files is_dir "/usr/bin" )
    assert_eq 0 "$actual" "is_dir should return true (0) if dir exists"
    if [[ "$?" == 0 ]]; then
      log_success "is_dir returns true (0)"
    else
      log_failure "is_dir should return true (0)"
    fi

    actual=$( files is_dir "/usr/something" )
    assert_eq 1 "$actual" "is_dir should return false (1) if dir not exists"
    if [[ "$?" == 0 ]]; then
      log_success "is_dir returns false (1)"
    else
      log_failure "is_dir should return false (1)"
    fi

    actual=$( files is_dir "test_files.sh" )
    assert_eq 1 "$actual" "is_dir should return false (1) if dir exists but regular file"
    if [[ "$?" == 0 ]]; then
      log_success "is_file returns false (1)"
    else
      log_failure "is_file should return false (1)"
    fi

  }

  test_exist() {
    log_header "Test exist"

    local actual

    actual=$( files exist "/usr/bin" )
    assert_eq 0 "$actual" "exist should return true (0) if path exists"
    if [[ "$?" == 0 ]]; then
      log_success "exist returns true (0)"
    else
      log_failure "exist should return true (0)"
    fi

    actual=$( files exist "/usr/something" )
    assert_eq 1 "$actual" "exist should return false (1) if path not exists"
    if [[ "$?" == 0 ]]; then
      log_success "exist returns false (1)"
    else
      log_failure "exist should return false (1)"
    fi
  }

  test_is_symlink() {
    log_header "Test is_symlink"

    local actual

    actual=$( files is_symlink "files/go_home" )
    assert_eq 0 "$actual" "is_symlink should return true (0) if file is symlink"
    if [[ "$?" == 0 ]]; then
      log_success "is_symlink returns true (0)"
    else
      log_failure "is_symlink should return true (0)"
    fi

    actual=$( files is_symlink "something" )
    assert_eq 1 "$actual" "is_symlink should return false (1) if file is not symlink"
    if [[ "$?" == 0 ]]; then
      log_success "is_symlink returns false (1)"
    else
      log_failure "is_symlink should return false (1)"
    fi
  }

  test_is_socket() {
    log_header "Test is_socket"

    local actual

    actual=$( files is_socket "/var/run/snapd.socket" )
    assert_eq 0 "$actual" "is_socket should return true (0) if file is socket"
    if [[ "$?" == 0 ]]; then
      log_success "is_socket returns true (0)"
    else
      log_failure "is_socket should return true (0)"
    fi

    actual=$( files is_socket "something" )
    assert_eq 1 "$actual" "is_socket should return false (1) if file is not socket"
    if [[ "$?" == 0 ]]; then
      log_success "is_socket returns false (1)"
    else
      log_failure "is_socket should return false (1)"
    fi
  }
  
  test_is_readable() {
    log_header "Test is_readable"

    local actual

    actual=$( files is_readable "files/rwx_file" )
    assert_eq 0 "$actual" "is_readable should return true (0) if file is readable"
    if [[ "$?" == 0 ]]; then
      log_success "is_readable returns true (0)"
    else
      log_failure "is_readable should return true (0)"
    fi

    actual=$( files is_readable "files/no_rwx_file" )
    assert_eq 1 "$actual" "is_readable should return false (1) if file is not readable"
    if [[ "$?" == 0 ]]; then
      log_success "is_readable returns false (1)"
    else
      log_failure "is_readable should return false (1)"
    fi
  }
  
  test_is_writable() {
    log_header "Test is_writable"

    local actual

    actual=$( files is_writable "files/rwx_file" )
    assert_eq 0 "$actual" "is_writable should return true (0) if file is writable"
    if [[ "$?" == 0 ]]; then
      log_success "is_writable returns true (0)"
    else
      log_failure "is_writable should return true (0)"
    fi

    actual=$( files is_writable "files/no_rwx_file" )
    assert_eq 1 "$actual" "is_writable should return false (1) if file is not writable"
    if [[ "$?" == 0 ]]; then
      log_success "is_writable returns false (1)"
    else
      log_failure "is_writable should return false (1)"
    fi
  }
   
  test_is_executable() {
    log_header "Test is_executable"

    local actual

    actual=$( files is_executable "files/rwx_file" )
    assert_eq 0 "$actual" "is_executable should return true (0) if file is executable"
    if [[ "$?" == 0 ]]; then
      log_success "is_executable returns true (0)"
    else
      log_failure "is_executable should return true (0)"
    fi

    actual=$( files is_executable "files/no_rwx_file" )
    assert_eq 1 "$actual" "is_executable should return false (1) if file is not executable"
    if [[ "$?" == 0 ]]; then
      log_success "is_executable returns false (1)"
    else
      log_failure "is_executable should return false (1)"
    fi
  }
  
  test_is_file
  test_is_dir
  test_exist
  test_is_symlink
  test_is_socket
  test_is_readable
  test_is_writable
  test_is_executable
}

test_files
