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
        $g->[$row][$col] = '.';
    }
}

while (<>) {
    chomp;
    my @val = split //;
    my $OFFSET = ($SIZE - @val) / 2;
    my $row = $. - 1 + $OFFSET;
    for my $i (0..$#val) {
        my $col = $i + $OFFSET;
        $g->[$row][$col] = $val[$i];
    }
}

my $cnt = 0;
my $d = 'u';
my ($row, $col) = (int($SIZE/2), int($SIZE/2));
for my $it (1..$ITER) {
    if ($g->[$row][$col] eq '#') {
        $d = turn_right($d);
        $g->[$row][$col] = '.';
    } else {
        $d = turn_left($d);
        $g->[$row][$col] = '#';
        $cnt++;
    }
    my ($drow, $dcol) = d2move($d);
    $row += $drow;
    $col += $dcol;
}
say "result1: $cnt";

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
