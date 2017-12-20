#!/usr/bin/env python3
from sys import argv
from Particle import *

part=[]
filename = argv[1]
with open(filename) as f:
    for line in f:
        part.append(Particle(line.rstrip()))

# for i in range(len(part)):
#     print(i, part[i].dump())

low_accel = 1e300
candidates = []

for i in range(len(part)):
    mag = part[i].accel_mag()
    if mag < low_accel:
        low_accel = mag
        candidates = [i]
    elif mag == low_accel:
        candidates.append(i)

print("result1:", candidates)

# if there were a tie, we'd also need to compare initial velocities
