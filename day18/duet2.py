#!/usr/bin/env python3
from sys import argv
import re

class Set:
    def __init__(self, tok1, tok2):
        self.tok1 = tok1
        self.tok2 = tok2

    def run(self, ip, r, q):
        val = int(self.tok2) if re.match('\d+', self.tok2) else r[self.tok2]
        r[self.tok1] = val
        return ip+1, None

class Add:
    def __init__(self, tok1, tok2):
        self.tok1 = tok1
        self.tok2 = tok2

    def run(self, ip, r, q):
        val = int(self.tok2) if re.search('\d+', self.tok2) else int(r[self.tok2])
        r[self.tok1] += val
        return ip+1, None

class Mul:
    def __init__(self, tok1, tok2):
        self.tok1 = tok1
        self.tok2 = tok2

    def run(self, ip, r, q):
        val = int(self.tok2) if re.search('\d+', self.tok2) else r[self.tok2]
        r[self.tok1] *= val
        return ip+1, None

class Mod:
    def __init__(self, tok1, tok2):
        self.tok1 = tok1
        self.tok2 = tok2

    def run(self, ip, r, q):
        val = int(self.tok2) if re.search('\d+', self.tok2) else r[self.tok2]
        r[self.tok1] %= val
        return ip+1, None

class Jgz:
    def __init__(self, tok1, tok2):
        self.tok1 = tok1
        self.tok2 = tok2

    def run(self, ip, r, q):
        val1 = r[self.tok1] if re.match('[a-z]', self.tok1) else int(self.tok1)
        val2 = r[self.tok2] if re.match('[a-z]', self.tok2) else int(self.tok2)
        if val1 > 0:
            return ip + val2, None
        else:
            return ip+1, None

class Snd:
    def __init__(self, tok1):
        self.tok1 = tok1

    def run(self, ip, r, q):
        if "pid1" in r:
            r['sent'] += 1
            
        val1 = r[self.tok1] if re.match('[a-z]', self.tok1) else int(self.tok1)
        return ip+1, val1

class Rcv:
    def __init__(self, tok1):
        self.tok1 = tok1

    def run(self, ip, r, q):
        if len(q) > 0:
            r[self.tok1] = q.pop(0)
            return ip+1, None
        else:
            return ip, None

r0 = {chr(i): 0 for i in range(ord('a'),ord('z')+1)}
r1 = {chr(i): 0 for i in range(ord('a'),ord('z')+1)}
r1['p'] = 1
r1['sent'] = 0
r1['pid1'] = 1

# parse the import and construct array of function pointers
pgm0 = []
pgm1 = []
filename = argv[1]
with open(filename) as f:
    for line in f:
        line = line.rstrip()
        tok = line.split(' ')
        if tok[0] == 'set':
            pgm0.append(Set(tok[1], tok[2]))
        elif tok[0] == 'add':
            pgm0.append(Add(tok[1], tok[2]))
        elif tok[0] == 'mul':
            pgm0.append(Mul(tok[1], tok[2]))
        elif tok[0] == 'mod':
            pgm0.append(Mod(tok[1], tok[2]))
        elif tok[0] == 'snd':
            pgm0.append(Snd(tok[1]))
        elif tok[0] == 'rcv':
            pgm0.append(Rcv(tok[1]))
        elif tok[0] == 'jgz':
            pgm0.append(Jgz(tok[1], tok[2]))
        pgm1.append(pgm0[-1])
            
# run the program
ip0 = 0
ip1 = 0
dead = False
q0 = []
q1 = []
while ip0 >= 0 and ip0 < len(pgm0) and ip1 >= 0 and ip1 < len(pgm1) and not dead:
    ip0a, val0 = pgm0[ip0].run(ip0, r0, q0)
    if val0 is not None:
        q1.append(val0)

    ip1a, val1 = pgm1[ip1].run(ip1, r1, q1)
    if val1 is not None:
        q0.append(val1)

    if ip0a == ip0 and ip1a == ip1 and len(q0) == 0 and len(q1) == 0:
        dead = True
    else:
        ip0 = ip0a
        ip1 = ip1a

print("result2:", r1["sent"])
