#include <iostream>
using namespace std;

int main(int argc, char *argv[]) {
//    unsigned long gen[] = {65, 8921};
    unsigned long gen[] = {116, 299};
    const unsigned long FACT[] = {16807, 48271};
//    const int PAIRS = 5;
    const int PAIRS = 40000000;
    int cnt = 0;

    for (int i = 0; i < PAIRS; i++) {
        for (int j = 0; j < 2; j++)
            gen[j] = (gen[j] * FACT[j]) % 2147483647;

        if ((gen[0] & 0xffff) == (gen[1] & 0xffff))
            cnt++;
    }

    cout << "result1: " << cnt << endl;
}
