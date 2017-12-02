#!/usr/bin/env python3
from sys import argv

def part1(vals):
    return max(vals) - min(vals)

def part2(vals):
    for i in range(len(vals)-1):
        for j in range(i+1, len(vals)):
            if vals[i] > vals[j]:
                x,y = vals[i], vals[j]
            else:
                x,y = vals[j], vals[i]
            if x % y == 0:
                return int(x/y)
    return 0

filename = argv[1]
sum1 = 0
sum2 = 0
with open(filename) as f:
    for line in f:
        vals = [int(x) for x in line.split()]
        sum1 += part1(vals)
        sum2 += part2(vals)

print("part1", sum1)
print("part2", sum2)


