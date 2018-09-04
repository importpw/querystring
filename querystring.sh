# Encodes the input with querystring percent-encoding.
# Similar to `encodeURIComponent()` in JavaScript.
#
# Examples:
#
# $ querystring_escape hello world
# hello%20world
#
querystring_escape() {
  local input=
  if [ $# -gt 0 ]; then
    input="$*"
  else
    # assume stdin
    input="$(cat)"
  fi
  printf "%s" "$input" | while IFS='' read -n 1 -r c; do
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


# Decodes querystring-encoded content
# Similar to `decodeURIComponent()` in JavaScript.
#
# Examples:
#
# $ querystring_unescape "hello%20world"
# hello world
#
# Credit: https://stackoverflow.com/a/37840948/376773
querystring_unescape() {
  local input="${*//+/ }"
  printf '%b' "${input//%/\\x}"
}
