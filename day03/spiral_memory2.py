#!/usr/bin/env python3
from sys import argv

def sum_adj(s, r, c):
    return (s[r-1][c-1] + s[r-1][c] + s[r-1][c+1] +
            s[r][c-1]               + s[r][c+1]   +
            s[r+1][c-1] + s[r+1][c] + s[r+1][c+1])

target = int(argv[1])
C = 10
s = [[0 for x in range(C*2)] for y in range(C*2)]

s[C][C] = 1
s[C][C+1] = 1
row,col = C,C+1
dr,dc = -1,0 # up

while True:
    row += dr
    col += dc
    s[row][col] = sum_adj(s, row, col)
    if s[row][col] > target:
        print("result2:", s[row][col])
        break

    # change direction?
    if row == col and row < C: #nw
        dr,dc = 1,0
    elif row > C and row == col-1: #se
        dr,dc = -1,0
    elif row-C == C-col:
        if row > C: #sw
            dr,dc = 0,1
        else: #ne
            dr,dc = 0,-1
