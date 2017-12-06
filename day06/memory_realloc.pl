#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

#my @b = (0, 2, 7, 0);
my @b = (0, 5, 10, 0, 11, 14, 13, 4, 11, 8, 8, 7, 1, 4, 12, 11);
my %seen;
my $steps = 0;
my $loop;

while (1) {
    # have we seen this config before?
    my $k = join ",", @b;
    if (defined($seen{$k})) {
        $loop = $steps - $seen{$k};
        last;
    } else {
        $seen{$k} = $steps;
    }

    # find band with most blocks
    my $most = -1;
    my $p = -1;
    for my $i (0..$#b) {
        if ($b[$i] > $most) {
            $most = $b[$i];
            $p = $i;
        }
    }

    # redistribute
    $b[$p] = 0;
    for (1..$most) {
        $p = ($p+1) % @b;
        $b[$p]++;
    }

    # repeat
    $steps++;
#    say "$steps\t@b";
}

say "result1: $steps";
say "result2: $loop";
