#!/usr/bin/env python3
from sys import argv

def emptyg(size):
    return [ [ 0 for y in range(size) ] for x in range(size) ]

def printg(g):
    for row in range(len(g)):
        for col in range(len(g)):
            if g[row][col] == 0:
                print('. ', end='')
            else:
                print('# ', end='')
        print('')
    print('')

def turn_right(d):
    if d == 'u':
        return 'r'
    elif d == 'r':
        return 'd'
    elif d == 'd':
        return 'l'
    else:
        return 'u'

def turn_left(d):
    if d == 'u':
        return 'l'
    elif d == 'l':
        return 'd'
    elif d == 'd':
        return 'r'
    else:
        return 'u'

def d2move(d):
    if d == 'u':
        return -1,0
    elif d == 'r':
        return 0,1
    elif d == 'd':
        return 1,0
    else:
        return 0,-1

ITER = int(argv[1])
SIZE = 999
g = emptyg(SIZE)

# parse the input
filename = argv[2]
lineno = 0
with open(filename) as f:
    for line in f:
        line = line.rstrip()
        offset = int((SIZE - len(line)) / 2)
        row = lineno + offset
        for i in range(len(line)):
            if line[i] == '#':
                col = i + offset
                g[row][col] = 1
        lineno += 1

# run ITER bursts
cnt = 0
d = 'u'
row,col = int(SIZE/2), int(SIZE/2)

for it in range(ITER):
    if g[row][col] == 0: # clean
        d = turn_left(d)
        g[row][col] = 1
        cnt += 1
    else: # infected
        d = turn_right(d)
        g[row][col] = 0

    drow, dcol = d2move(d)
    row += drow
    col += dcol

print("result1:", cnt)
