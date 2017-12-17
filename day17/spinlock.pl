#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

my $stride = $ARGV[0];

my @buf = (0);
my $p = 0;

for my $i (1..2017) {
    $p = ($p + $stride) % @buf;
    splice @buf, $p+1, 0, $i;
    $p++;
}

for my $i (0..$#buf) {
    if ($buf[$i] == 2017) {
        my $j = ($i+1) % @buf;
        say "result1: $buf[$j]";
        last;
    }
}
