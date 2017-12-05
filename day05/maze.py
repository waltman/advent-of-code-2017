#!/usr/bin/env python3
from sys import argv

# read in the program
filename = argv[1]
pgm = []
with open(filename) as f:
    for line in f:
        pgm.append(int(line))

# run the program
ip = 0
steps = 0
while ip >= 0 and ip < len(pgm):
    tmp = ip
    ip += pgm[tmp]
    pgm[tmp] += 1
    steps += 1

print("result1:", steps)
