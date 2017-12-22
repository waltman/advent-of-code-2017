#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

my $ITER = shift @ARGV;
my $SIZE = 9999;
my @g = map { [split '', '.' x $SIZE] } 1..$SIZE;

while (<>) {
    chomp;
    my @val = split //;
    my $OFFSET = ($SIZE - @val) / 2;
    my $row = $. - 1 + $OFFSET;
    for my $i (0..$#val) {
        my $col = $i + $OFFSET;
        $g[$row][$col] = $val[$i];
    }
}

my $cnt = 0;
my $d = 'u';
my ($row, $col) = (int($SIZE/2), int($SIZE/2));
for my $it (1..$ITER) {
    my $val = $g[$row][$col];
    if ($val eq '.') {
        $d = turn_left($d);
        $g[$row][$col] = 'W';
    } elsif ($val eq '#') {
        $d = turn_right($d);
        $g[$row][$col] = 'F';
    } elsif ($val eq 'W') {
        $g[$row][$col] = '#'; # infected
        $cnt++;
    } elsif ($val eq 'F') { # flagged
        $d = turn_reverse($d);
        $g[$row][$col] = '.'; # clean
    }
    my ($drow, $dcol) = d2move($d);
    $row += $drow;
    $col += $dcol;
}
say "result2: $cnt";

sub printg($g) {
    for my $row (0..$#$g) {
        for my $col (0..$#$g) {
            print "$g->[$row][$col] ";
        }
        print "\n";
    }
    print "\n";
}

sub turn_right($d) {
    if ($d eq 'u') {
        return 'r';
    } elsif ($d eq 'r') {
        return 'd';
    } elsif ($d eq 'd') {
        return 'l';
    } else {
        return 'u';
    }
}

sub turn_left($d) {
    if ($d eq 'u') {
        return 'l';
    } elsif ($d eq 'l') {
        return 'd';
    } elsif ($d eq 'd') {
        return 'r';
    } else {
        return 'u';
    }
}

sub turn_reverse($d) {
    if ($d eq 'u') {
        return 'd';
    } elsif ($d eq 'l') {
        return 'r';
    } elsif ($d eq 'd') {
        return 'u';
    } else {
        return 'l';
    }
}

sub d2move($d) {
    if ($d eq 'u') {
        return (-1, 0);
    } elsif ($d eq 'r') {
        return (0, 1);
    } elsif ($d eq 'd') {
        return (1, 0);
    } else {
        return (0, -1);
    }
}
