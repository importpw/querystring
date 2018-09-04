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


querystring_parse() {
  local name
  local next
  local value
  local input="$1"
  shift

  local i=1
  next="$(echo "$input" | awk -F'&' '{print $1}')"
  while [ -n "$next" ]; do
    name="$(echo "$next" | awk -F= '{print $1}' | querystring_unescape)"

    for wanted in $*; do
      if [ "$wanted" = "$name" ]; then
        value="$(echo "$next" | awk '{print substr($0, '"$(( ${#name} + 2 ))"')}' | querystring_unescape)"
        eval "$name=$(echo "$value" | sed -e "s/'/'\\\\''/g; 1s/^/'/; \$s/\$/'/")"
        break
      fi
    done

    i="$(( i + 1 ))"
    next="$(echo "$input" | awk -F'&' '{print $'"$i"'}')"
  done
}
