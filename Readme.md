# querystring

Shell script helper functions for encoding/decoding query-string data.

## Example

```bash
#!/usr/bin/env import

import querystring@1.1.0

querystring_escape "hello world"
# hello%20world

querystring_unescape "hello%20world"
# hello world
```
