#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

# sieve
my $MAX = 125100;
my @isPrime = map {1} (0..$MAX);
$isPrime[0] = $isPrime[1] = 0;

for my $i (2..$MAX) {
    if ($isPrime[$i]) {
        for (my $j = $i*2; $j <= $MAX; $j += $i) {
            $isPrime[$j] = 0;
        }
    }
}

my $cnt = 0;
for (my $i = 108100; $i <= 125100; $i += 17) {
    $cnt++ unless $isPrime[$i];
}

say "result2: $cnt";
