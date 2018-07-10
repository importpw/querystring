#!/bin/sh
set -eu
eval "`curl -fsSL import.pw`"
source ./querystring.sh
import "import.pw/assert@2.1.1"

assert_equal "$(querystring_escape "!")" "%21"
assert_equal "$(querystring_escape hello world)" "hello%20world"

assert_equal "$(querystring_unescape "%21")" "@"
assert_equal "$(querystring_unescape "hello%20world")" "hello world"


test_escape_unescape() {
  local input="$*"
  local escaped="$(querystring_escape "${input}")"
  local normal="$(querystring_unescape "${escaped}")"
  assert_equal "${input}" "${normal}"
}

test_escape_unescape a
test_escape_unescape foo123
test_escape_unescape Hello World
test_escape_unescape " !@#$%^&*() "
