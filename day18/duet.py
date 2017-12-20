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

class Add:
    def __init__(self, tok1, tok2):
        self.tok1 = tok1
        self.tok2 = tok2

    def run(self, ip, r):
        val = int(self.tok2) if re.search('\d+', self.tok2) else int(r[self.tok2])
        r[self.tok1] += val
        return ip+1

class Mul:
    def __init__(self, tok1, tok2):
        self.tok1 = tok1
        self.tok2 = tok2

    def run(self, ip, r):
        val = int(self.tok2) if re.search('\d+', self.tok2) else r[self.tok2]
        r[self.tok1] *= val
        return ip+1

class Mod:
    def __init__(self, tok1, tok2):
        self.tok1 = tok1
        self.tok2 = tok2

    def run(self, ip, r):
        val = int(self.tok2) if re.search('\d+', self.tok2) else r[self.tok2]
        r[self.tok1] %= val
        return ip+1

class Snd:
    def __init__(self, tok1):
        self.tok1 = tok1

    def run(self, ip, r):
        r['snd'] = r[self.tok1]
        return ip+1

class Rcv:
    def __init__(self, tok1):
        self.tok1 = tok1

    def run(self, ip, r):
        if r[self.tok1] != 0:
            r['rcv'] = r['snd']
            return -1
        else:
            return ip+1

class Jgz:
    def __init__(self, tok1, tok2):
        self.tok1 = tok1
        self.tok2 = tok2

    def run(self, ip, r):
        if r[self.tok1] > 0:
            return ip + int(self.tok2)
        else:
            return ip+1

r = {chr(i): 0 for i in range(ord('a'),ord('z')+1)}
r["snd"] = None
r["rcv"] = None

# parse the import and construct array of function pointers
pgm = []
filename = argv[1]
with open(filename) as f:
    for line in f:
        line = line.rstrip()
        tok = line.split(' ')
        if tok[0] == 'set':
            pgm.append(Set(tok[1], tok[2]))
        elif tok[0] == 'add':
            pgm.append(Add(tok[1], tok[2]))
        elif tok[0] == 'mul':
            pgm.append(Mul(tok[1], tok[2]))
        elif tok[0] == 'mod':
            pgm.append(Mod(tok[1], tok[2]))
        elif tok[0] == 'snd':
            pgm.append(Snd(tok[1]))
        elif tok[0] == 'rcv':
            pgm.append(Rcv(tok[1]))
        elif tok[0] == 'jgz':
            pgm.append(Jgz(tok[1], tok[2]))
            
# run the program
ip = 0
while ip >= 0 and ip < len(pgm):
    ip = pgm[ip].run(ip, r)

print("result1:", r["rcv"])
