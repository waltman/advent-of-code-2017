#!/usr/bin/env python3
from sys import argv

stride = int(argv[1])
MAX = 2017
buf = [0]
p = 0

for i in range(1, MAX+1):
    p = (p + stride) % len(buf)
    buf.insert(p+1, i)
    p += 1

for i in range(len(buf)):
    if buf[i] == 2017:
        j = (i + 1) % len(buf)
        print("result1:", buf[j])
        break
