#!/usr/bin/env python3
from sys import argv

def is_valid(line):
    s = set()
    for pw in line.split():
        if pw in s:
            return 0
        else:
            s.add(pw)
            
    return 1
    
def is_valid2(line):
    s = set()
    keys = [''.join(sorted(list(pw))) for pw in line.split()]
    for key in keys:
        if key in s:
            return 0
        else:
            s.add(key)
            
    return 1
    

filename = argv[1]
sum1 = 0
sum2 = 0

with open(filename) as f:
    for line in f:
        if is_valid(line):
            sum1 += 1
        if is_valid2(line):
            sum2 += 1

print("result1:", sum1)
print("result2:", sum2)
