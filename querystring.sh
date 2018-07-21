#!/bin/bash
querystring_escape() {
  local input=
  if [ $# -gt 0 ]; then
    input="$*"
  else
    # assume stdin
    input="$(cat)"
  fi
  local length="${#input}"
  for (( i = 0; i < length; i++ )); do
    local c="${input:i:1}"
    if [ "$c" = "!" ] || [ "$c" = "(" ] || [ "$c" = ")" ] || [ "$c" = "'" ] || [ "$c" = "*" ]; then
      printf "$c"
    else
      case $c in
        [a-zA-Z0-9.~_-]) printf "$c" ;;
        *) printf '%%%02X' "'$c"
      esac
    fi
  done
}

# https://stackoverflow.com/a/37840948/376773
querystring_unescape() { : "${*//+/ }"; printf "%b" "${_//%/\\x}"; }
