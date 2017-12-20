#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);
use lib '.';
use Particle;

my @part;

while (<>) {
    chomp;
    push @part, Particle->new($_);
}

my $low_accel = 1e300;
my @candidates;

for my $i (0..$#part) {
    my $mag = $part[$i]->accel_mag();
    if ($mag < $low_accel) {
        $low_accel = $mag;
        @candidates = ($i);
    } elsif ($mag == $low_accel) {
        push @candidates, $i;
    }
}
say "result1: @candidates";

# if there were a tie, we'd also need to compare initial velocities
