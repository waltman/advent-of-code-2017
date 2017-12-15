#!/usr/bin/env python3

#gen = [65, 8921]
gen = [116, 299]
FACT = [16807, 48271]
# PAIRS = 5
PAIRS = 40000000
cnt = 0

for _ in range(PAIRS):
    for i in range(2):
        gen[i] = (gen[i] * FACT[i]) % 2147483647
        
    if (gen[0] & 0xffff) == (gen[1] & 0xffff):
        cnt += 1

print("result1:", cnt)
