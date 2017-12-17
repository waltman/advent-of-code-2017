#include <iostream>
#include <stdlib.h>
#include <forward_list>
#include <time.h>

using namespace std;

int main(int argc, char *argv[]) {
    forward_list<int> buf = { 0 };
    int stride = atoi(argv[1]);
    auto p = buf.begin();

    for (int i = 1; i <= 2017; i++) {
        for (int j = 0; j < stride; j++) {
            p++;
            if (p == buf.end())
                p = buf.begin();
        }
        buf.insert_after(p, i);
        p++;
    }

    for (auto p = buf.begin(); p != buf.end(); p++) {
        if (*p == 2017) {
            auto q = p;
            q++;
            if (q == buf.end())
                q = buf.begin();
            cout << "result1: " << *q << endl;
        }
    }
}

            
