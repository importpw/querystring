#!/bin/bash
eval "`curl -sfLS import.pw`"
source ./querystring.sh
import "import.pw/assert@1.1.0"

assert.equal "$(querystring.escape hello world)" "hello%20world"
