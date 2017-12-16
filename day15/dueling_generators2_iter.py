#!/usr/bin/env python3

class DuelGen:
    """Class to implement an iterator for the generators in part 2
    of Advent of Code Day 15"""

    def __init__(self, startVal, factor, mod):
        self.val = startVal
        self.fact = factor
        self.mod = mod

    def __iter__(self):
        return self

    def __next__(self):
        self.val = (self.val * self.fact) % 2147483647
        while self.val % self.mod != 0:
            self.val = (self.val * self.fact) % 2147483647
        return self.val

# startVal = [65, 8921]; # test
startVal = [116, 299];
FACT = [16807, 48271]
MOD = [4, 8]
PAIRS = 5000000
gen = [iter(DuelGen(startVal[i], FACT[i], MOD[i])) for i in range(2)]
cnt = 0

for i in range(PAIRS):
    if (next(gen[0]) & 0xffff) == (next(gen[1]) & 0xffff):
        cnt += 1

print("result2:", cnt)


