#usr/bin/env python

# gen = [65, 8921]; # test
gen = [116, 299];
FACT = [16807, 48271]
MOD = [4, 8]
# PAIRS = 5 # test
PAIRS = 5000000
cnt = 0;
vals = []

for i in range(2):
    valsi = []
    while len(valsi) < PAIRS:
        gen[i] = (gen[i] * FACT[i]) % 2147483647
        if gen[i] % MOD[i] == 0:
            valsi.append(gen[i])
    vals.append(valsi)

for i in range(PAIRS):
    if (vals[0][i] & 0xffff) == (vals[1][i] & 0xffff):
        cnt += 1

print("result2:", cnt)
