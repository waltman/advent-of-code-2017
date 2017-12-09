#include <iostream>
#include <fstream>
#include <string>
#include <regex>

using namespace std;

int main(int argc, char *argv[]) {
    regex re_cancel("!.");
    regex re_garbage("<([^>]*)>");
    
    ifstream infile(argv[1]);
    string line;
    if (infile.is_open()) {
        while (getline(infile, line)) {
            // remove cancels
            line = regex_replace(line, re_cancel, "");

            // compute how many chars are inside garbage
            int garbage_len = 0;
            sregex_iterator next(line.begin(), line.end(), re_garbage);
            sregex_iterator end;
            while (next != end) {
                garbage_len += next->str(1).size();
                next++;
            }

            // remove garbage
            line = regex_replace(line, re_garbage, "");

            // compute score
            int score = 0;
            int level = 0;
            for (auto c : line) {
                if (c == '{') {
                    level++;
                } else if (c == '}') {
                    score += level;
                    level--;
                }
            }

            cout << "score = " << score << endl;
            cout << "garbage length = " << garbage_len << endl;
        }
    }
}
