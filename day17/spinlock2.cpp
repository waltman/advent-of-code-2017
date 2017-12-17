#include <stdlib.h>
#include <iostream>

using namespace std;

int main(int argc, char *argv[]) {
    int stride = atoi(argv[1]);

    const int MAX = 50000000;
    int len = 1;
    int res = 0;
    int p = 0;

    for (int i = 1; i <= MAX; i++, p++, len++) {
        p = (p + stride) % len;
        if (p == 0)
            res = i;
    }

    cout << "result2 " << res << endl;
}
