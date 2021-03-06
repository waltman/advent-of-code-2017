#/usr/bin/env python3

# test data
#myList = [x for x in range(0,5)]
#LENS = (3, 4, 1, 5)

# problem data
myList = [x for x in range(0,256)]
LENS = [147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70]

p = 0
skip = 0

for myLen in LENS:
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

print("result1:", myList[0] * myList[1])
