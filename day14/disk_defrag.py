#/usr/bin/env python3
from sys import argv
import networkx as nx

def knot_hash(lens_str):
    myList = [x for x in range(0,256)]
    STD_SUFFIX = [17, 31, 73, 47, 23]
    lens = [ord(c) for c in lens_str] + STD_SUFFIX

    p = 0
    skip = 0

    for round in range(1,65):
        for myLen in lens:
            end = p + myLen - 1
            if end < len(myList):
                slice = myList[p:end+1]
                myList[p:end+1] = slice[::-1]
            else:
                tmp = myList + myList
                slice = tmp[p:end+1]
                tmp[p:end+1] = slice[::-1]
                tmp[0:(end-len(myList)+1)] = tmp[len(myList):end+1]
                myList = tmp[0:len(myList)]

            p = (p + myLen + skip) % len(myList)
            skip += 1

    # compute dense hash from myList
    dense = []
    for i in range(0,256,16):
        out = myList[i]
        for j in range(i+1,i+16):
            out ^= myList[j]
        dense.append(out)

    hash = []
    for val in dense:
        bits = "{:08b}".format(val)
        hash += [int(x) for x in bits]
    return hash

key = argv[1]
total = 0
disk = []
for i in range(128):
    keyi = "{}-{:d}".format(key, i)
    hash = knot_hash(keyi)
    total += sum(hash)
    disk.append(hash)

print("result1:", total)

g = nx.Graph()

# add vertex for each used square
for r in range(128):
    for c in range(128):
        if disk[r][c]:
            key = "{},{}".format(r,c)
            g.add_node(key)

# rows
for r in range(128):
    for c in range(128-1):
        if disk[r][c] and disk[r][c+1]:
            fromKey = "{},{}".format(r,c)
            toKey = "{},{}".format(r,c+1)
            g.add_edge(fromKey, toKey)
            
# cols
for r in range(128-1):
    for c in range(128):
        if disk[r][c] and disk[r+1][c]:
            fromKey = "{},{}".format(r,c)
            toKey = "{},{}".format(r+1,c)
            g.add_edge(fromKey, toKey)
            
cc = list(nx.connected_components(g))
print("result2:", len(cc))
