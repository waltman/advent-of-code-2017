#include <iostream>
#include <vector>
#include "array2d.h"
using namespace std;

class DuelGen {
private:
    unsigned long _val;
    unsigned long _fact;
    unsigned long _mod;

    void genNextVal() { _val = (_val * _fact) % 2147483647; }

public:
    DuelGen(const unsigned long startVal, const unsigned long factor, const unsigned long mod) {
        _val = startVal;
        _fact = factor;
        _mod = mod;
    }

    unsigned long next() {
        do {
            genNextVal();
        } while (_val % _mod != 0);
        return _val;
    }
};

int main(int argc, char *argv[]) {
//    unsigned long gen[] = {65, 8921};
    unsigned long startVal[] = {116, 299};
    const unsigned long FACT[] = {16807, 48271};
    const unsigned long MOD[] = {4, 8};
    vector<DuelGen> gen;
//    const int PAIRS = 5;
    const int PAIRS = 5000000;

    for (int i = 0; i < 2; i++)
        gen.push_back(DuelGen(startVal[i], FACT[i], MOD[i]));
        
    int cnt = 0;
    for (int i = 0; i < PAIRS; i++)
        if ((gen[0].next() & 0xffff) == (gen[1].next() & 0xffff))
            cnt++;

    cout << "result2: " << cnt << endl;
}
