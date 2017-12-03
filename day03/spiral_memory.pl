#!/usr/bin/env perl
use strict;
use warnings;
use feature ":5.26";
use experimental 'signatures';
use List::Util qw(min);

my $target = $ARGV[0];
my $layer = 1;
my $c = 3;
my $corner = $c**2;
my ($e,$n,$w,$s) = (2, 4, 6, 8);
my $delta = 9;

while ($target > $corner) {
    $layer++;
    $c += 2;
    $corner = $c**2;

    $e += $delta; $delta += 2;
    $n += $delta; $delta += 2;
    $w += $delta; $delta += 2;
    $s += $delta; $delta += 2;
}

my $d = $layer + min(abs($target-$e),
                     abs($target-$n),
                     abs($target-$w),
                     abs($target-$s));

say "result1: $d";
