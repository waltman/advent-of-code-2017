#!/usr/bin/env python3
from sys import argv
import re

class State:
    def __init__(self, w0, m0, c0, w1, m1, c1):
        self.w0 = w0
        self.m0 = m0
        self.c0 = c0
        self.w1 = w1
        self.m1 = m1
        self.c1 = c1

    def run(self, ip, tape):
        if tape[ip] == 0:
            tape[ip] = self.w0
            return ip+self.m0, self.c0
        else:
            tape[ip] = self.w1
            return ip+self.m1, self.c1

# parse out the turing machine
pgm = {}
filename = argv[1]
rule = ''
with open(filename) as f:
    for line in f:
        if line[0] != '\n':
            rule += line
        else:
            if rule[0] == 'B':
                m = re.search('state (.).*after (\d+)', rule, flags=re.S)
                init_state = m.group(1)
                max_steps = int(m.group(2))
                rule = ''
            else:
                m = re.search("""In state (.):
  If the current value is 0:
    - Write the value (\d)\.
    - Move one slot to the ([^.]+)\.
    - Continue with state (.)\.
  If the current value is 1:
    - Write the value (\d)\.
    - Move one slot to the ([^.]+)\.
    - Continue with state (.)\.""", rule, flags=re.S)
                state = m.group(1)
                w0 = int(m.group(2))
                m0 = -1 if m.group(3) == 'left' else 1
                c0 = m.group(4)
                w1 = int(m.group(5))
                m1 = -1 if m.group(6) == 'left' else 1
                c1 = m.group(7)
                pgm[state] = State(w0, m0, c0, w1, m1, c1)
                rule = ''

# run the turning machine
TAPELEN = 12000
state = init_state
tape = [0 for x in range(TAPELEN)]
ip = int(TAPELEN/2)

for step in range(1, max_steps+1):
    ip, state = pgm[state].run(ip, tape)

print("result1:", sum(tape))
