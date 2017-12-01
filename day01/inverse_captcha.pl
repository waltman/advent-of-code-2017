#!/usr/bin/env perl
use strict;
use warnings;
use feature ":5.26";
use experimental 'signatures';

while (<>) {
    chomp;
    my @c = split //;
    my $sum1 = 0;
    my $sum2 = 0;
    my $step2 = @c/2;
    for my $i (0..$#c) {
        $sum1 += $c[$i] if $c[$i] == $c[($i+1) % @c];
        $sum2 += $c[$i] if $c[$i] == $c[($i+$step2) % @c];
    }

    say "result1 is $sum1";
    say "result2 is $sum2";
}
