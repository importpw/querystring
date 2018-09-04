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


# Credit: https://stackoverflow.com/a/37840948/376773
querystring_unescape() {
  local input=
  if [ $# -gt 0 ]; then
    input="$*"
  else
    # assume stdin
    input="$(cat)"
  fi
  input="${input//+/ }"
  printf '%b' "${input//%/\\x}"
}
