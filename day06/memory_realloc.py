#!/usr/bin/env python3

#b = [0, 2, 7, 0]
b = [0, 5, 10, 0, 11, 14, 13, 4, 11, 8, 8, 7, 1, 4, 12, 11]

seen = {}
steps = 0
loop = 0

while 1:
    # have we seen this config before?
    k = ','.join([str(x) for x in b])
    if k in seen:
        loop = steps - seen[k]
        break
    else:
        seen[k] = steps

    # find the band with the most blocks
    most = -1
    p = -1
    for i in range(len(b)):
        if b[i] > most:
            most = b[i]
            p = i

    # redistribute
    b[p] = 0
    for _ in range(most):
        p = (p+1) % len(b)
        b[p] += 1

    # repeat
    steps = steps + 1
#    print(steps, "\t", b)

print("result1:", steps)
print("result2:", loop)
