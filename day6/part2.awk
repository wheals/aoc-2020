#!/bin/awk -f

BEGIN { RS = "\n\n"; FS = "\n" }
{ for (c = 97; c <= 122; c += 1) {
    matches = 0
    for (field = 1; field <= NF; field += 1)
        if ($field ~ sprintf("%c", c))
            matches += 1
    if (matches == NF)
        count += 1
  }
}
END { print count }