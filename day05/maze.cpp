#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <stdlib.h>

using namespace std;

int main(int argc, char *argv[]) {
    // read in the program
    vector<int> pgm;
    ifstream infile(argv[1]);
    string line;
    if (infile.is_open()) {
        while (getline(infile, line)) {
            pgm.push_back(atoi(line.c_str()));
        }
    }
    infile.close();

    // run the program
    int ip = 0;
    int steps = 0;
    while (ip >= 0 && ip < (int) pgm.size()) {
        int tmp = ip;
        ip += pgm[tmp];
        pgm[tmp]++;
        steps++;
    }

    cout << "result1: " << steps << endl;
}
