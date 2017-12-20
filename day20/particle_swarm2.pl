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

my $MAX_TICKS = 100; # worked empirically on my data
for my $t (1..$MAX_TICKS) {
    $_->tick() for @part;
    for my $i (0..$#part-1) {
        for my $j ($i+1..$#part) {
            if ($part[$i]->collision($part[$j])) {
                $part[$i]->set_hit(1);
                $part[$j]->set_hit(1);
            }
        }
    }
    @part = grep {$_->unhit()} @part;
    say "t=$t, remain=", scalar @part;
}

say "result2: ", scalar @part;
