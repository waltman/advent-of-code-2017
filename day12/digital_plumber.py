#!/usr/bin/env python3
from sys import argv
import networkx as nx
import re

# parse the input
G = nx.Graph()
filename = argv[1]
with open(filename) as f:
    for line in f:
        line = line.rstrip("\n")
        m = re.search('^(\d+) <-> (.*)$', line)
        fromv = int(m.group(1))
        tos = [int(x) for x in m.group(2).split(', ')]
        for tov in tos:
            G.add_edge(fromv, tov)

cc = list(nx.connected_components(G))
print("result1:", len(cc[0]))
print("result2:", len(cc))

