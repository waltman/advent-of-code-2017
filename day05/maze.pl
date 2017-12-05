#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

# read in the program
my @pgm;

while (<>) {
    chomp;
    push @pgm, $_;
}

# run the program;
my $ip = 0;
my $steps = 0;
while ($ip >= 0 && $ip <= $#pgm) {
    my $tmp = $ip;
    $ip += $pgm[$tmp];
    $pgm[$tmp]++;
    $steps++;
}

say "result1: $steps";
