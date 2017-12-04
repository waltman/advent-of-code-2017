#!/usr/bin/env perl
use strict;
use warnings;
use feature ":5.24";
use experimental 'signatures';

my $cnt = 0;
my $cnt2 = 0;
while (<>) {
    chomp;
    $cnt++ if is_valid($_);
    $cnt2++ if is_valid2($_);
}

say "result1: $cnt";
say "result2: $cnt2";

sub is_valid($s) {
    my %h;
    my @a = split / /, $s;
    for (@a) {
        return 0 if defined $h{$_};
        $h{$_} = 1;
    }

    return 1;
}

sub is_valid2($s) {
    my %h;
    my @a = map {join "", sort split //} split / /, $s;
    for (@a) {
        return 0 if defined $h{$_};
        $h{$_} = 1;
    }

    return 1;
}
