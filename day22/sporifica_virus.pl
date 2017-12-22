#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

my $ITER = shift @ARGV;
my $SIZE = 999;
my $g;
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
        $g->[$row][$col] = $val[$i] eq '.' ? 0 : 2;
    }
}

my $cnt = 0;
my ($drow, $dcol) = (-1, 0);
my ($row, $col) = (int($SIZE/2), int($SIZE/2));
for my $it (1..$ITER) {
    if ($g->[$row][$col] == 2) {
        ($drow, $dcol) = turn_right($drow, $dcol);
        $g->[$row][$col] = 1;
    } else {
        ($drow, $dcol) = turn_left($drow, $dcol);
        $g->[$row][$col] = 2;
        $cnt++;
    }
    $row += $drow;
    $col += $dcol;
}
say "result1: $cnt";

sub printg($g) {
    for my $row (0..$#$g) {
        for my $col (0..$#$g) {
            my $val = $g->[$row][$col];
            if ($val == 0 || $val == 1) {
                print ". ";
            } elsif ($val == 2) {
                print "# ";
            } elsif ($val == 3) {
                print "* ";
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

