#!/usr/bin/env python3
from sys import argv

stride = int(argv[1])
MAX = 50000000
length = 1
res = 0
p = 0

for i in range(1, MAX+1):
    p = (p + stride) % length
    if p == 0:
        res = i
    p += 1
    length += 1

print("result2:", res)
