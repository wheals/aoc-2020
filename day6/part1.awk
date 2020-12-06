#!/bin/awk -f

BEGIN { RS = "\n\n"; FS = "\n\n" }
{ for (c = 97; c <= 122; c += 1)
    if ($1 ~ sprintf("%c", c))
        count += 1
}
END { print count }
