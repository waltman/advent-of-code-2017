#!/usr/bin/env python3

MIN = 108100
MAX = 125100
STRIDE = 17

# sieve
isPrime = set()
for i in range(MAX+1):
    isPrime.add(i)

for i in range(2, MAX+1):
    if i in isPrime:
        for j in range(i*2, MAX+1, i):
            if j in isPrime:
                isPrime.remove(j)

cnt = 0
for i in range(MIN, MAX+1, STRIDE):
    if i not in isPrime:
        cnt += 1

print("result2:", cnt)
