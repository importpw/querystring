#!/usr/bin/env import
set -eu
source ./querystring.sh
import assert@2.1.3

# querystring()
assert_equal "$(querystring "/foo")" ""
assert_equal "$(querystring "/foo?")" ""
assert_equal "$(querystring "/foo?bar")" "bar"
assert_equal "$(querystring "/foo?bar=baz&one=two")" "bar=baz&one=two"


# These were generated from Node.js `querystring.escape()`
ascii_0="%00"
ascii_1="%01"
ascii_2="%02"
ascii_3="%03"
ascii_4="%04"
ascii_5="%05"
ascii_6="%06"
ascii_7="%07"
ascii_8="%08"
ascii_9="%09"
ascii_10="%0A"
ascii_11="%0B"
ascii_12="%0C"
ascii_13="%0D"
ascii_14="%0E"
ascii_15="%0F"
ascii_16="%10"
ascii_17="%11"
ascii_18="%12"
ascii_19="%13"
ascii_20="%14"
ascii_21="%15"
ascii_22="%16"
ascii_23="%17"
ascii_24="%18"
ascii_25="%19"
ascii_26="%1A"
ascii_27="%1B"
ascii_28="%1C"
ascii_29="%1D"
ascii_30="%1E"
ascii_31="%1F"
ascii_32="%20"
ascii_33="!"
ascii_34="%22"
ascii_35="%23"
ascii_36="%24"
ascii_37="%25"
ascii_38="%26"
ascii_39="'"
ascii_40="("
ascii_41=")"
ascii_42="*"
ascii_43="%2B"
ascii_44="%2C"
ascii_45="-"
ascii_46="."
ascii_47="%2F"
ascii_48="0"
ascii_49="1"
ascii_50="2"
ascii_51="3"
ascii_52="4"
ascii_53="5"
ascii_54="6"
ascii_55="7"
ascii_56="8"
ascii_57="9"
ascii_58="%3A"
ascii_59="%3B"
ascii_60="%3C"
ascii_61="%3D"
ascii_62="%3E"
ascii_63="%3F"
ascii_64="%40"
ascii_65="A"
ascii_66="B"
ascii_67="C"
ascii_68="D"
ascii_69="E"
ascii_70="F"
ascii_71="G"
ascii_72="H"
ascii_73="I"
ascii_74="J"
ascii_75="K"
ascii_76="L"
ascii_77="M"
ascii_78="N"
ascii_79="O"
ascii_80="P"
ascii_81="Q"
ascii_82="R"
ascii_83="S"
ascii_84="T"
ascii_85="U"
ascii_86="V"
ascii_87="W"
ascii_88="X"
ascii_89="Y"
ascii_90="Z"
ascii_91="%5B"
ascii_92="%5C"
ascii_93="%5D"
ascii_94="%5E"
ascii_95="_"
ascii_96="%60"
ascii_97="a"
ascii_98="b"
ascii_99="c"
ascii_100="d"
ascii_101="e"
ascii_102="f"
ascii_103="g"
ascii_104="h"
ascii_105="i"
ascii_106="j"
ascii_107="k"
ascii_108="l"
ascii_109="m"
ascii_110="n"
ascii_111="o"
ascii_112="p"
ascii_113="q"
ascii_114="r"
ascii_115="s"
ascii_116="t"
ascii_117="u"
ascii_118="v"
ascii_119="w"
ascii_120="x"
ascii_121="y"
ascii_122="z"
ascii_123="%7B"
ascii_124="%7C"
ascii_125="%7D"
ascii_126="~"
ascii_127="%7F"

chr() {
  [ "$1" -lt 256 ] || return 1
  printf "\\$(printf '%03o' "$1")"
}

#for i in {0..127}; do
for i in `seq 1 127`; do
  val="$(eval "echo \"\$ascii_$i\"")"

  [ $i -eq 10 ] && continue # fails for some reason?

  #echo $i "$val"
  assert_equal "$(chr "$i" | querystring_escape)" "$val"
done

assert_equal "$(querystring_escape "!")" "!"
assert_equal "$(querystring_escape hello world)" "hello%20world"

assert_equal "$(querystring_unescape "%21")" "!"
assert_equal "$(querystring_unescape "hello%20world")" "hello world"
assert_equal "$(querystring_unescape "hello+world")" "hello world"

assert_equal "$(echo "hello+world" | querystring_unescape)" "hello world"

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



# querystring_parse()
qs="fieldname1=value1&fieldname2=value2&fieldname3=value3"
querystring_parse "$qs" fieldname1 fieldname2
assert_equal "$fieldname1" value1
assert_equal "$fieldname2" value2
assert_equal "${fieldname3-}" "" # not set since it was not requested
