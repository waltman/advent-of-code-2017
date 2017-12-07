#!/usr/bin/env python3
from sys import argv
import re

def tree_weight(root, children, weight):
    sum = weight[root]
    if root in children:
        for t in children[root]:
            sum += tree_weight(t, children, weight)

    return sum

def check_balance(weights):
    h = {}

    for i in range(len(weights)):
        w = weights[i]
        if w not in h:
            h[w] = []
        h[w].append(i)

    k = list(h.keys())
    size = [len(h[x]) for x in k]

    if len(k) == 1: # balanced
        idx, delta = -1, -1
    else:
        if size[0] == 1:
            idx = h[k[0]][0]
            delta = k[1] - k[0]
        else:
            idx = h[k[1]][0]
            delta = k[0] - k[1]

    return idx, delta

# parse the input
parents = {}
children = {}
weights = {}

filename = argv[1]
with open(filename) as f:
    for line in f:
        line = line.rstrip("\n")
        token = line.split(" -> ")
        m = re.search("([a-z]+) \((\d+)", token[0])
        name = m.group(1)
        weight = int(m.group(2))
        weights[name] = weight
        if len(token) == 2:
            disks = token[1].split(", ")
            for disk in disks:
                parents[disk] = name
                if name not in children:
                    children[name] = []
                children[name].append(disk)

# find the root
allRoots = list(parents.keys())
root = allRoots[0]
while root in parents:
    root = parents[root]
print("result1:", root)

# find weights of root's subtrees
rootWeights = []
for subtree in children[root]:
    rootWeights.append(tree_weight(subtree, children, weights))

idx, delta = check_balance(rootWeights)

# search for the bad disk
found = False
while (not found):
    root = children[root][idx]
    rootWeights = []
    for subtree in children[root]:
        rootWeights.append(tree_weight(subtree, children, weights))

    idx, _ = check_balance(rootWeights)
    if idx == -1:
        print("result2:", weights[root] + delta)
        found = True
    else:
        print("not found, checking", children[root][idx])
