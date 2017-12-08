#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);
use List::Util qw(max);

my %reg;
my $highest = -1e300;

while (<>) {
    chomp;
    my @tok = split / /;

    # create registers if they don't exist
    $reg{$tok[0]} //= 0;
    $reg{$tok[4]} //= 0;

    # create command
    $tok[0] = "\$reg\{$tok[0]\}";
    $tok[4] = "\$reg\{$tok[4]\}";
    $tok[1] = ($tok[1] eq 'inc') ? '+=' : '-=';
    my $cmd = join " ", @tok;
    eval $cmd;
    my $high = max(values(%reg));
    $highest = max($high, $highest);
}

say "result1: ", max(values(%reg));
say "result2: $highest";
