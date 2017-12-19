#!/usr/bin/env python3
from sys import argv
import re

# parse the maze
maze = []
filename = argv[1]
with open(filename) as f:
    for line in f:
        line = line.rstrip("\n")
        maze.append(line)

# find the opening position
row = 0
col = 0
for i in range(len(maze[0])):
    if maze[0][i] == '|':
        col = i
        break

# walk through the maze
drow, dcol = 1,0 # down
done = False
letters = ""
steps = 0
while not done:
    row += drow
    col += dcol
    steps += 1
    val = maze[row][col]
    if val == ' ': # ran out of space, so finished!
        done = True
    elif re.match('[A-Z]', val):
        letters += val
    elif val == '+': # turn
        if dcol == 0: # look left and right
            if maze[row][col-1] != ' ':
                drow, dcol = 0, -1 # left
            else:
                drow, dcol = 0, 1  # right
        else: # look up and down
            if maze[row-1][col] != ' ':
                drow, dcol = -1, 0 # up
            else:
                drow, dcol = 1, 0  # down

print("result1:", letters)
print("result2:", steps)

