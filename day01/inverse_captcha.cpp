#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int part1(const string &s, const int step) {
    int len = s.length();
    int sum = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == s[(i+step) % len]) {
            sum += s[i] - '0';
        }
    }
    return sum;
}

int main(int argc, char *argv[]) {
    ifstream infile(argv[1]);
    string line;
    if (infile.is_open()) {
        while (getline(infile, line)) {
            cout << "result 1: " << part1(line, 1) << endl;
            cout << "result 2: " << part1(line, line.length()/2) << endl;
        }
    }
    infile.close();
    return 0;
}
