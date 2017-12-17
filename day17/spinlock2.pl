#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

my $stride = $ARGV[0];

my $MAX = 50_000_000;
my $len = 1;
my $res = 0;
my $p = 0;

for my $i (1..$MAX) {
    $p = ($p + $stride) % $len;
    $res = $i if $p == 0;
    $p++;
    $len++;
}
say "result2: $res";
