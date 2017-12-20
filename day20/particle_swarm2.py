#!/usr/bin/env python3
from sys import argv
from Particle import *

part=[]
filename = argv[1]
with open(filename) as f:
    for line in f:
        part.append(Particle(line.rstrip()))

MAX_TICKS = 100 # worked empirically on my data
for t in range(1, MAX_TICKS+1):
    for p in part:
        p.tick()
    for i in range(0, len(part)-1):
        for j in range(i+1, len(part)):
            if part[i].collision(part[j]):
                part[i].set_hit()
                part[j].set_hit()

    part = [x for x in part if x.unhit()]
    print("t=", t, "remain=", len(part))

print("result2:", len(part))

    
