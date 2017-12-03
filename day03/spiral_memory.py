#!/usr/bin/env python3
from sys import argv

target = int(argv[1])
layer = 1
c = 3
corner = c**2
e,n,w,s = 2,4,6,8
delta = 9

while target > corner:
    layer += 1
    c += 2
    corner = c**2

    e += delta; delta += 2
    n += delta; delta += 2
    w += delta; delta += 2
    s += delta; delta += 2

d = layer + min(abs(target-e),
                abs(target-n),
                abs(target-w),
                abs(target-s))

print("result1:", d)
