#!/usr/bin/env python3
from sys import argv
import re

class Set:
    def __init__(self, tok1, tok2):
        self.tok1 = tok1
        self.tok2 = tok2

    def run(self, ip, r):
        val = int(self.tok2) if re.match('\d+', self.tok2) else r[self.tok2]
        r[self.tok1] = val
        return ip+1

class Sub:
    def __init__(self, tok1, tok2):
        self.tok1 = tok1
        self.tok2 = tok2

    def run(self, ip, r):
        val = int(self.tok2) if re.search('\d+', self.tok2) else int(r[self.tok2])
        r[self.tok1] -= val
        return ip+1

class Mul:
    def __init__(self, tok1, tok2):
        self.tok1 = tok1
        self.tok2 = tok2

    def run(self, ip, r):
        val = int(self.tok2) if re.search('\d+', self.tok2) else r[self.tok2]
        r[self.tok1] *= val
        r['mul'] += 1
        return ip+1

class Jnz:
    def __init__(self, tok1, tok2):
        self.tok1 = tok1
        self.tok2 = tok2

    def run(self, ip, r):
        val1 = r[self.tok1] if re.match('[a-z]', self.tok1) else int(self.tok1)
        val2 = r[self.tok2] if re.match('[a-z]', self.tok2) else int(self.tok2)
        if val1 != 0:
            return ip + val2
        else:
            return ip+1

r = { chr(i): 0 for i in range(ord('a'), ord('h')+1) }
r['mul'] = 0

# parse the input into an array of object
pgm = []
filename = argv[1];
with open(filename) as f:
    for line in f:
        line = line.rstrip()
        tok = line.split(' ');
        if tok[0] == 'set':
            pgm.append(Set(tok[1], tok[2]))
        elif tok[0] == 'sub':
            pgm.append(Sub(tok[1], tok[2]))
        elif tok[0] == 'mul':
            pgm.append(Mul(tok[1], tok[2]))
        elif tok[0] == 'jnz':
            pgm.append(Jnz(tok[1], tok[2]))
        else:
            print("WTF?", line)

# run the program
ip = 0
while True:
    try:
        ip = pgm[ip].run(ip, r)
    except IndexError:
        print("result1:", r['mul'])
        break
