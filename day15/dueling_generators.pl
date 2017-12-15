#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

# my @gen = (65, 8921); # test
my @gen = (116, 299);
my @fact = (16807, 48271);
my $PAIRS = 40_000_000;
my $cnt = 0;

for (1..$PAIRS) {
    $gen[$_] = ($gen[$_] * $fact[$_]) % 2147483647 for 0..1;
    $cnt++ if ($gen[0] & 0xffff) == ($gen[1] & 0xffff);
}

say "result1: $cnt";
