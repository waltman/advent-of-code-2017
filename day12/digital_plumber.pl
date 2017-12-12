#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);
use Graph::Undirected;

my $g = Graph::Undirected->new;

# parse the input
while (<>) {
    chomp;
    $_ =~ /^(\d+) <-> (.*)$/;
    my $from = $1;
    my @tos = split /, /, $2;
    for my $to (@tos) {
        $g->add_edge($from, $to);
    }
}

my @cc = $g->connected_components();
for my $cc (@cc) {
    if (grep {$_ == 0} @$cc) {
        say "result1: ", scalar @$cc;
        last;
    }
}

say "result2: ", scalar @cc;
