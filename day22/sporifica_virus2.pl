#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

my $ITER = shift @ARGV;
my $SIZE = 9999;
my $g;
my %init_infect;
for my $row (0..$SIZE-1) {
    for my $col (0..$SIZE-1) {
        $g->[$row][$col] = 0;
    }
}

while (<>) {
    chomp;
    my @val = split //;
    my $OFFSET = ($SIZE - @val) / 2;
    my $row = $. - 1 + $OFFSET;
    for my $i (0..$#val) {
        my $col = $i + $OFFSET;
        if ($val[$i] eq '.') {
            $g->[$row][$col] = 0;
        } else {
            $g->[$row][$col] = 1;
            $init_infect{"$row,$col"} = 1;
        }
    }
}

my $cnt = 0;
my ($drow, $dcol) = (-1, 0);
my ($row, $col) = (int($SIZE/2), int($SIZE/2));
for my $it (1..$ITER) {
    my $val = $g->[$row][$col];
    if ($val == 0) { # clean
        ($drow, $dcol) = turn_left($drow, $dcol);
        $g->[$row][$col] = 2; # weakened
    } elsif ($val == 1) { # infected
        ($drow, $dcol) = turn_right($drow, $dcol);
        $g->[$row][$col] = 3; # flagged
    } elsif ($val == 2) { # weakened
        $g->[$row][$col] = 1; # infected
        $cnt++;
    } elsif ($val == 3) { # flagged
        ($drow, $dcol) = turn_reverse($drow, $dcol);
        $g->[$row][$col] = 0; # clean
    }
    $row += $drow;
    $col += $dcol;
}
say "result1: $cnt";

sub printg($g) {
    for my $row (0..$#$g) {
        for my $col (0..$#$g) {
            my $val = $g->[$row][$col];
            if ($val == 0) {
                print ". ";
            } elsif ($val == 1) {
                print "# ";
            } elsif ($val == 2) {
                print "W ";
            } elsif ($val == 3) {
                print "F ";
            }
        }
        print "\n";
    }
    print "\n";
}

sub turn_right($dx, $dy) {
    if ($dx == -1) { # up
        return (0, 1); # right
    } elsif ($dx == 1) { # down
        return (0, -1); # left
    } elsif ($dy == -1) { # left
        return (-1, 0); # up
    } else { # right
        return (1, 0); # down
    }
}

sub turn_left($dx, $dy) {
    if ($dx == -1) { # up
        return (0, -1); # left
    } elsif ($dx == 1) { # down
        return (0, 1); # right
    } elsif ($dy == -1) { # left
        return (1, 0); # down
    } else { # right
        return (-1, 0); # up
    }
}

sub turn_reverse($dx, $dy) {
    if ($dx == -1) { # up
        return (1, 0); # down
    } elsif ($dx == 1) { # down
        return (-1, 0); # up
    } elsif ($dy == -1) { # left
        return (0, 1); # right
    } else { # right
        return (0, -1); # left
    }
}

