#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

while (<>) {
    # remove newline
    chomp;

    # remove cancels
    s/!.//g;

    # remove garbage
    my $garbage_len = 0;
    $garbage_len += length $1 while s/<([^>]*)>//;

    # compute score
    my @c = split //;
    my $score = 0;
    my $level = 0;

    for my $c (@c) {
        if ($c eq '{') {
            $level++;
        } elsif ($c eq '}') {
            $score += $level;
            $level--;
        }
    }
    say "score = $score";
    say "garbage length = $garbage_len";
}
