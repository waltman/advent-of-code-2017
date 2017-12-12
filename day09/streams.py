#!/usr/bin/env python3
from sys import argv
import re

p = re.compile('<([^>]*)>')
filename = argv[1]
with open(filename) as f:
    for line in f:
        # remove newline
        line = line.rstrip("\n")
        
        # remove cancels
        line = re.sub('!.', '', line)

        # remove garbage
        garbage_len = 0
        m = p.search(line)
        while m is not None:
            garbage_len += len(m.group(1))
            line = p.sub('', line, count=1)
            m = p.search(line)

        # compute score
        score = 0
        level = 0
        for c in line:
            if c == '{':
                level += 1
            elif c == '}':
                score += level
                level -= 1

        print("score =", score)
        print("garbage length =", garbage_len)
        
