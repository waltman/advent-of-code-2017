#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

# my @gen = (65, 8921); # test
my @gen = (116, 299);
my @fact = (16807, 48271);
my @mod = (4, 8);
# my $PAIRS = 5; # test
my $PAIRS = 5_000_000;
my $cnt = 0;

my @vals;
for my $i (0..1) {
    $vals[$i] = [];
    while (@{$vals[$i]} < $PAIRS) {
        $gen[$i] = ($gen[$i] * $fact[$i]) % 2147483647;
        push @{$vals[$i]}, $gen[$i] if $gen[$i] % $mod[$i] == 0;
    }
}

for my $i (0..$PAIRS-1) {
    $cnt++ if ($vals[0][$i] & 0xffff) == ($vals[1][$i] & 0xffff);
}

say "result2: $cnt";
