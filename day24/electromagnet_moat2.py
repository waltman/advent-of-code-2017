#!/usr/bin/env python3
from sys import argv

has = {}
weight = {}
maxl = 0
maxw = 0
maxb = ''

def make_bridge(target, bridge):
    global maxl
    global maxw
    global maxb
    
    used = { port for port in bridge }
    ports = [ port for port in has[target] if port not in used ]
    if (len(ports) > 0):
        for port in ports:
            b2 = bridge + [port]
            t2 = other_side(port, target)
            make_bridge(t2, b2)
    else:
        l = bridge_length(bridge)
        w = bridge_weight(bridge)
        if l > maxl or (l == maxl and w > maxw):
            maxl = l
            maxw = w
            maxb = '--'.join(bridge)
            print("{}\t{}\t{}".format(maxl, maxw, maxb))

def other_side(port, side1):
    p0,p1 = [ int(x) for x in port.split('/') ]
    return p1 if p0 == side1 else p0

def bridge_weight(bridge):
    return sum([ weight[port] for port in bridge ])        

def bridge_length(bridge):
    return len(bridge)

# parse the input
filename = argv[1]
with open(filename) as f:
    for line in f:
        line = line.rstrip()

        p0,p1 = [ int(x) for x in line.split('/') ]
        if p0 not in has:
            has[p0] = [line]
        else:
            has[p0].append(line)
        if p0 != p1:
            if p1 not in has:
                has[p1] = [line]
            else:
                has[p1].append(line)
        weight[line] = p0 + p1

make_bridge(0, [])
