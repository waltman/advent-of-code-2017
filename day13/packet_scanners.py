#!/usr/bin/env python3
from sys import argv
import re

# parse the input
fw = []
filename = argv[1]
with open(filename) as f:
    for line in f:
        line = line.rstrip()
        m = re.search('(\d+): (\d+)', line)
        layer = int(m.group(1))
        for _ in range(len(fw), layer):
            fw.append(None)
        fw.append(int(m.group(2)))

# compute severity
severity = 0
for i in range(len(fw)):
    if fw[i] is not None and i % (2 * (fw[i]-1)) == 0:
        severity += i * fw[i]

print("result1:", severity)

# now let's try to get through without getting caught!
delay = 0
ok = False
while (not ok):
    ok = True
    for i in range(len(fw)):
        if fw[i] is not None and (delay + i) % (2 * (fw[i]-1)) == 0:
            ok = False
            break
    if not ok:
        delay += 1

print("result2:", delay)
