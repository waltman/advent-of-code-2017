#!/usr/bin/env python3
from sys import argv

def printg(g):
    for row in range(len(g)):
        for col in range(len(g)):
            print(g[row][col], end='')
        print('')
    print('')

def rule2g(rule):
    line = rule.split('/')
    g = [list(x) for x in line]
    return g

def g2rule(g):
    return '/'.join([''.join(x) for x in g])

def flip2(g):
    g2 = [ [ None for y in range(2) ] for x in range(2) ]
    g2[0][0] = g[0][1]
    g2[0][1] = g[0][0]
    g2[1][0] = g[1][1]
    g2[1][1] = g[1][0]

    return g2

def rot2(g):
    g2 = [ [ None for y in range(2) ] for x in range(2) ]
    g2[0][0] = g[1][0]
    g2[0][1] = g[0][0]
    g2[1][0] = g[1][1]
    g2[1][1] = g[0][1]

    return g2

def flip3(g):
    g3 = [ [ None for y in range(3) ] for x in range(3) ]
    g3[0][0] = g[0][2]
    g3[0][1] = g[0][1]
    g3[0][2] = g[0][0]
    g3[1][0] = g[1][2]
    g3[1][1] = g[1][1]
    g3[1][2] = g[1][0]
    g3[2][0] = g[2][2]
    g3[2][1] = g[2][1]
    g3[2][2] = g[2][0]

    return g3

def rot3(g):
    g3 = [ [ None for y in range(3) ] for x in range(3) ]
    g3[0][0] = g[0][2]
    g3[0][1] = g[1][2]
    g3[0][2] = g[2][2]
    g3[1][0] = g[0][1]
    g3[1][1] = g[1][1]
    g3[1][2] = g[2][1]
    g3[2][0] = g[0][0]
    g3[2][1] = g[1][0]
    g3[2][2] = g[2][0]

    return g3


ITER = int(argv[1])

# parse the input
rule = {}
filename = argv[2]
with open(filename) as f:
    for line in f:
        line = line.rstrip()
        frule, trule = line.split(' => ')
        g = rule2g(frule)
        if len(frule) == 5:
            for i in range(4):
                rule[g2rule(g)] = trule
                rule[g2rule(flip2(g))] = trule
                g = rot2(g)
        else:
            for i in range(4):
                rule[g2rule(g)] = trule
                rule[g2rule(flip3(g))] = trule
                g = rot3(g)

g = rule2g('.#./..#/###')
for it in range(ITER):
    length = len(g)
    if length % 2 == 0:
        newlen = int(length/2*3)
        g2 = [ [ None for y in range(newlen) ] for x in range(newlen) ]
        for row in range(0, length, 2):
            r2 = int(row/2*3)
            for col in range(0, length, 2):
                c2 = int(col/2*3)
                k = "{}{}/{}{}".format(g[row][col],   g[row][col+1],
                                       g[row+1][col], g[row+1][col+1])

                outg = rule2g(rule[k])
                for i in range(3):
                    for j in range(3):
                        g2[r2+i][c2+j] = outg[i][j]
    else:
        newlen = int(length/3*4)
        g2 = [ [ None for y in range(newlen) ] for x in range(newlen) ]
        for row in range(0, length, 3):
            r2 = int(row/3*4)
            for col in range(0, length, 3):
                c2 = int(col/3*4)
                k = "{}{}{}/{}{}{}/{}{}{}".format(g[row][col],   g[row][col+1],   g[row][col+2],
                                                  g[row+1][col], g[row+1][col+1], g[row+1][col+2],
                                                  g[row+2][col], g[row+2][col+1], g[row+2][col+2])
                outg = rule2g(rule[k])
                for i in range(4):
                    for j in range(4):
                        g2[r2+i][c2+j] = outg[i][j]
    g = g2

cnt = 0
for row in range(len(g)):
    for col in range(len(g)):
        if g[row][col] == '#':
            cnt += 1

print("result:", cnt)
print(len(g), "x", len(g))
