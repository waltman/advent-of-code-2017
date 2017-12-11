#!/usr/bin/env python 3
from sys import argv

filename = argv[1]
with open(filename) as f:
    for line in f:
        line = line.rstrip("\n")
        moves = line.split(",")
        row = 0
        col = 0
        far = 0
        for move in moves:
            if move == "n":
                row += 2
            elif move == "ne":
                row += 1
                col += 1
            elif move == "se":
                row -= 1
                col += 1
            elif move == "s":
                row -= 2
            elif move == "sw":
                row -= 1
                col -= 1
            elif move == "nw":
                row += 1
                col -= 1

            d = int((abs(row) + abs(col)) / 2)
            far = max(far, d)

        d = int((abs(row) + abs(col)) / 2)
        print("result1:", d)
        print("result2:", far)
