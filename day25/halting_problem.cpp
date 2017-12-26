#include <iostream>
#include <fstream>
#include <string>
#include <regex>
#include <map>
#include <tuple>
#include <string.h>

using namespace std;

class State {
private:
    int _w0;
    int _m0;
    char _c0;
    int _w1;
    int _m1;
    char _c1;

public:
    State(int w0, int m0, char c0, int w1, int m1, char c1) :
        _w0(w0), _m0(m0), _c0(c0), _w1(w1), _m1(m1), _c1(c1) {}

    State() : State(0, 0, 0, 0, 0, 0) {}

    tuple<int, char> run(int ip, int *tape) {
        if (tape[ip] == 0) {
            tape[ip] = _w0;
            return make_tuple(ip + _m0, _c0);
        } else {
            tape[ip] = _w1;
            return make_tuple(ip + _m1, _c1);
        }
    }
};

void print_tape(int *tape, int len) {
    for (int i = 0; i < len; i++)
        cout << tape[i] << ' ';
    cout << endl;
}

int main(int argc, char *argv[]) {
    map<char, State> pgm;
    ifstream infile(argv[1]);
    string rule;
    char init_state = 0;
    int max_steps = 0;

    regex re1("state (.).*after (\\d+)");
    regex re2("state (.).*value (\\d).*the ([^.]+).*state (.).*value (\\d).*the ([^.]+).*state (.)");
    
    if (infile.is_open()) {
        string line;
        while (getline(infile, line)) {
            smatch m;
            if (line[0] != '\0') {
                rule += line;
            } else {
                if (rule[0] == 'B') {
                    regex_search(rule, m, re1);
                    init_state = m.str(1)[0];
                    max_steps = stoi(m.str(2));
                    rule = "";
                } else {
                    regex_search(rule, m, re2);
                    char state = m.str(1)[0];
                    int w0 = stoi(m.str(2));
                    int m0 = m.str(3) == "left" ? -1 : 1;
                    char c0 = m.str(4)[0];
                    int w1 = stoi(m.str(5));
                    int m1 = m.str(6) == "left" ? -1 : 1;
                    char c1 = m.str(7)[0];
                    State s(w0, m0, c0, w1, m1, c1);
                    pgm[state] = s;
                    rule = "";
                }
            }
        }
    }

    const int TAPELEN = 12000;
    char state = init_state;
    int tape[TAPELEN];
    int ip = TAPELEN/2;
    memset(tape, 0, TAPELEN * sizeof(int));

    for (int step = 1; step <= max_steps; step++) {
        auto next_state = pgm[state].run(ip, tape);
        ip = get<0>(next_state);
        state = get<1>(next_state);
    }

    int cnt = 0;
    for (auto& n : tape)
        cnt += n;

    cout << "result1: " << cnt << endl;
}
