#include <iostream>
#include "array2d.h"
using namespace std;

int main(int argc, char *argv[]) {
//    unsigned long gen[] = {65, 8921};
    unsigned long gen[] = {116, 299};
    const unsigned long FACT[] = {16807, 48271};
    const unsigned long MOD[] = {4, 8};
//    const int PAIRS = 5;
    const int PAIRS = 5000000;
    int cnt = 0;

    array2d<unsigned long> vals(2, PAIRS);
    for (int i = 0; i < 2; i++) {
        int j = 0;
        while (j < PAIRS) {
            gen[i] = (gen[i] * FACT[i]) % 2147483647;
            if (gen[i] % MOD[i] == 0)
                vals(i, j++) = gen[i];
        }
    }

    for (int i = 0; i < PAIRS; i++) {
        if ((vals(0,i) & 0xffff) == (vals(1,i) & 0xffff))
            cnt++;
    }

    cout << "result2: " << cnt << endl;
}
