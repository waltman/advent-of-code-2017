#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min max);
use feature ":5.26";
use experimental 'signatures';

my $sum1 = 0;
my $sum2 = 0;
while (<>) {
    chomp;
    my @vals = split /\s+/;
    $sum1 += max(@vals) - min(@vals);
    $sum2 += part2(\@vals);
}

say "result1 = $sum1";
say "result2 = $sum2";

sub part2($vals) {
    for my $i (0..$#$vals-1) {
        for my $j ($i+1..$#$vals) {
            my ($x, $y);
            if ($vals->[$i] > $vals->[$j]) {
                ($x, $y) = ($vals->[$i], $vals->[$j]);
            } else {
                ($x, $y) = ($vals->[$j], $vals->[$i]);
            }
            if ($x % $y == 0) {
                return $x/$y;
            }
        }
    }
    return 0;
}

