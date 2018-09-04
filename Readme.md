# querystring

Shell script helper functions for encoding/decoding querystring data.


## Example

```bash
#!/usr/bin/env import

import querystring@1.1.1

querystring_escape "hello world"
# hello%20world

querystring_unescape "hello%20world"
# hello world
```


## API

### `querystring_escape $input`

Encodes the input with querystring percent-encoding.
Similar to `encodeURIComponent()` in JavaScript.

```bash
#!/usr/bin/env import
import querystring@1.1.1

querystring_escape hello world
# hello%20world

# Also works over stdin
echo hello world | querystring_escape
# hello%20world
```


### `querystring_unescape $input`

Decodes querystring-encoded content.
Similar to `decodeURIComponent()` in JavaScript.

```bash
#!/usr/bin/env import
import querystring@1.1.1

querystring_unescape "hello%20world"
# hello world
```


### `querystring_parse $qs $var1 <... $var2>`

Parses the provided `qs` querystring and sets the requested shell variables.

```bash
#!/usr/bin/env import
import querystring@1.1.1

querystring_parse "one=1&two=2&three=3" one two

echo "$one"
# 1

echo "$two"
# 2

echo "$three"
# Not set, since it was not requested in `querystring_parse`
```
