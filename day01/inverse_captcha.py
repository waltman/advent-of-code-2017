#!/usr/bin/env python3
from sys import argv

script, filename = argv
with open(filename) as f:
    for line in f:
        line = line.rstrip("\n")
        sum1 = 0
        sum2 = 0
        step2 = int(len(line) / 2)
        for i in range(len(line)):
            if line[i] == line[(i+1) % len(line)]:
                sum1 += int(line[i])
            if line[i] == line[(i+step2) % len(line)]:
                sum2 += int(line[i])

        print("result1", sum1)
        print("result2", sum2)
        
