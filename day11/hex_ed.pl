#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

while (<>) {
    chomp;
    my @moves = split /,/;
    my ($row, $col) = (0, 0);
    my $far = 0;
    for my $move (@moves) {
	if ($move eq "n") {
	    $row += 2;
	} elsif ($move eq "ne") {
	    $row++;
	    $col++;
	} elsif ($move eq "se") {
	    $row--;
	    $col++;
	} elsif ($move eq "s") {
	    $row -= 2;
	} elsif ($move eq "sw") {
	    $row--;
	    $col--;
	} elsif ($move eq "nw") {
	    $row++;
	    $col--;
	}
	my $d = (abs($row) + abs($col)) / 2;
	$far = $d if $d > $far;
    }
    my $d = (abs($row) + abs($col)) / 2;
    say "result1: $d";
    say "result2: $far";
}
