#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

my @moves;
while (<>) {
    chomp;
    @moves = split /,/;
}

#my @pgm = 'a'..'e';
my @pgm = 'a'..'p';
for my $move (@moves) {
    my $cmd = substr $move, 0, 1;
    if ($cmd eq 's') {
        $move =~ /s(\d+)/;
        @pgm = (@pgm[-$1..-1], @pgm[0..$#pgm-$1]);
    } elsif ($cmd eq 'x') {
        $move =~ /x(\d+)\/(\d+)/;
        my $tmp = $pgm[$1];
        $pgm[$1] = $pgm[$2];
        $pgm[$2] = $tmp;
    } elsif ($cmd eq 'p') {
        my @tok = split //, $move;
        my %h = map { $pgm[$_] => $_ } 0..$#pgm;
        my $tmp = $pgm[$h{$tok[1]}];
        $pgm[$h{$tok[1]}] = $pgm[$h{$tok[3]}];
        $pgm[$h{$tok[3]}] = $tmp;
    }
}

say "result1: ", join "", @pgm;
