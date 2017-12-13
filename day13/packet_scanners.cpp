#include <iostream>
#include <fstream>
#include <string>
#include <regex>
#include <vector>

using namespace std;

int main(int argc, char *argv[]) {
    vector<int> fw;
    regex re("(\\d+): (\\d+)");

    ifstream infile(argv[1]);
    string line;
    if (infile.is_open()) {
        while (getline(infile, line)) {
            // parse out the 2 tokens
            smatch m;
            regex_search(line, m, re);
            int layer = stoi(m.str(1));
            int len = stoi(m.str(2));
            for (int i = fw.size(); i < layer; i++)
                fw.push_back(-1);
            fw.push_back(len);
        }
    }
    infile.close();

    // compute severity
    int severity = 0;
    for (size_t i = 0; i < fw.size(); i++)
        if (fw[i] >= 0 && i % (2 * (fw[i]-1)) == 0)
            severity += i * fw[i];
    printf("result1: %d\n", severity);

    // delays to get through without getting caught
    int delay = 0;
    int ok = 0;
    while (!ok) {
        ok = 1;
        for (size_t i = 0; i < fw.size(); i++) {
            if (fw[i] >= 0 && (delay + i) % (2 * (fw[i]-1)) == 0) {
                ok = 0;
                break;
            }
        }
        if (!ok)
            delay++;
    }
    printf("result2: %d\n", delay);
}
