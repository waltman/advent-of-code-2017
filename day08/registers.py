#!/usr/bin/env python3
from sys import argv

reg = {}
highest = -1e300
filename = argv[1]
with open(filename) as f:
    for line in f:
        line = line.rstrip("\n")
        tok = line.split(" ")

        # create registers if they don't exist
        if tok[0] not in reg:
            reg[tok[0]] = 0
        if tok[4] not in reg:
            reg[tok[4]] = 0

        # create command
        tok[0] = "reg['{}']".format(tok[0])
        tok[4] = "reg['{}']".format(tok[4])
        tok[1] = "+=" if tok[1] == "inc" else "-="
        cmd = "if {} {} {}: {} {} {}".format(tok[4], tok[5], tok[6], tok[0], tok[1], tok[2])
        exec(cmd)
        high = max(reg.values())
        highest = max(high, highest)

print("result1:", max(reg.values()))
print("result2:", highest)
