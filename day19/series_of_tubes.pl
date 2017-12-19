#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

# read in the maze
my @maze;
while (<>) {
    chomp;
    push @maze, [split //];
}

# find the opening position
my $len = @{$maze[0]};
my $row = 0;
my $col;
for my $i (0..$len-1) {
    if ($maze[0][$i] eq '|') {
        $col = $i;
        last;
    }
}

# walk through the maze
my ($drow, $dcol) = (1, 0); # down
my $done = 0;
my $letters = "";
my $steps = 0;
while (!$done) {
    $row += $drow;
    $col += $dcol;
    $steps++;
    my $val = $maze[$row][$col];
    if ($val eq ' ') { # ran out of space, so finished!
        $done = 1;
    } elsif ($val =~ /[A-Z]/) {
        $letters .= $val;
    } elsif ($val eq '+') { # turn!
        if ($dcol == 0) { # look left and right
            if ($maze[$row][$col-1] ne ' ') {
                ($drow, $dcol) = (0, -1); # left
            } else {
                ($drow, $dcol) = (0, 1);  # right
            }
        } else { # look up and down
            if ($maze[$row-1][$col] ne ' ') {
                ($drow, $dcol) = (-1, 0); # up
            } else {
                ($drow, $dcol) = (1, 0);  #down
            }
        }
    }
}

say "result1: $letters";
say "result2: $steps";
