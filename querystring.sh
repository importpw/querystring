#!/bin/bash
querystring_escape() {
  local input="$*"
  local length="${#input}"
  for (( i = 0; i < length; i++ )); do
    local c="${input:i:1}"
    case $c in
      [a-zA-Z0-9.~_-]) printf "$c" ;;
      *) printf '%%%02X' "'$c"
    esac
  done
}

# https://stackoverflow.com/a/37840948/376773
querystring_unescape() { : "${*//+/ }"; printf "%b" "${_//%/\\x}"; }
