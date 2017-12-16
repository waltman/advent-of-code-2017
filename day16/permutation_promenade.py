#!/usr/bin/env python3
from sys import argv
import re

# parse the input
moves = []
filename = argv[1]
with open(filename) as f:
    for line in f:
        line = line.rstrip()
        moves = line.split(",")

pgm = [chr(x + ord('a')) for x in range(16)]

for move in moves:
    cmd = move[0]
    if cmd == 's':
        m = re.search('s(\d+)', move)
        pos = len(pgm) - int(m.group(1))
        pgm = pgm[pos:] + pgm[:pos]
    elif cmd == 'x':
        m = re.search('x(\d+)/(\d+)', move)
        pos1 = int(m.group(1))
        pos2 = int(m.group(2))
        tmp = pgm[pos1]
        pgm[pos1] = pgm[pos2]
        pgm[pos2] = tmp
    elif cmd == 'p':
        d = {v: i for (i,v) in enumerate(pgm)}
        tmp = pgm[d[move[1]]]
        pgm[d[move[1]]] = pgm[d[move[3]]]
        pgm[d[move[3]]] = tmp

print("result1:", "".join(pgm))


