#include <iostream>
#include <fstream>
#include <string>
#include <stdlib.h>
#include "array2d.h"

using namespace std;

struct v {
    int x;
    int y;
};

void printg(array2d<char> &g) {
    for (int x = 0; x < g.x_dim(); x++) {
        for (int y = 0; y < g.y_dim(); y++) {
            printf("%c ", g(x,y));
        }
        printf("\n");
    }
    printf("\n");
}

const char turn_right(const char d) {
    switch (d) {
        case 'u': return 'r';
        case 'r': return 'd';
        case 'd': return 'l';
        default : return 'u';
    }
}

const char turn_rev(const char d) {
    switch (d) {
        case 'u': return 'd';
        case 'r': return 'l';
        case 'd': return 'u';
        default : return 'r';
    }
}

const struct v d2move(const char d) {
    struct v move = {0, 0};
    switch (d) {
        case 'u': move.x = -1; break;
        case 'r': move.y = 1;  break;
        case 'd': move.x = 1;  break;
        case 'l': move.y = -1; break;
    }
    return move;
}

const char turn_left(const char d) {
    switch (d) {
        case 'u': return 'l';
        case 'l': return 'd';
        case 'd': return 'r';
        default : return 'u';
    }
}

int main(int argc, char *argv[]) {
    const int SIZE = 501;
    int iter = atoi(argv[1]);
    array2d<char> g(SIZE, SIZE, '.');

    // parse the input
    ifstream infile(argv[2]);
    string line;
    int lineno = 0;
    if (infile.is_open()) {
        while (getline(infile, line)) {
            size_t len = line.size();
            size_t offset = (SIZE - len)/2;
            size_t row = lineno + offset;
            for (size_t i = 0; i < len; i++) {
                size_t col = i + offset;
                g(row, col) = line[i];
            }
            lineno++;
        }
    }

    int cnt = 0;
    char d = 'u';
    int row = SIZE/2;
    int col = SIZE/2;
    for (int it = 0; it < iter; it++) {
        const char val = g(row,col);
        if (val == '.') {
            d = turn_left(d);
            g(row,col) = 'W';
        } else if (val == '#' ) {
            d = turn_right(d);
            g(row,col) = 'F';
        } else if (val == 'W' ) {
            g(row,col) = '#';
            cnt++;
        } else {
            d = turn_rev(d);
            g(row,col) = '.';
        }
        struct v move = d2move(d);
        row += move.x;
        col += move.y;
    }

    printf("result2: %d\n", cnt);
}
