#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);
use List::Util qw(sum);

my %has;
my %weight;
while (<>) {
    chomp;
    my ($p0, $p1) = split '/';
    push @{$has{$p0}}, $_;
    push @{$has{$p1}}, $_ unless $p0 == $p1;
    $weight{$_} = $p0 + $p1;
}

my $maxw = 0;
my $maxb;

make_bridge(0, []);

sub make_bridge($target, $bridge) {
    my %used = map { $_ => 1 } @$bridge;
    my @next = grep { !$used{$_} } @{$has{$target}};
    if (@next) {
        for my $port (@next) {
            my @b2 = (@$bridge, $port);
            my $t2 = other_side($port, $target);
            make_bridge($t2, \@b2);
        }
    } else {
        my $w = bridge_weight($bridge);
        if ($w > $maxw) {
            $maxw = $w;
            $maxb = join '--', @$bridge;
            say "$maxw\t$maxb";
        }
    }
}

sub other_side($port, $side1) {
    my ($p0, $p1) = split '/', $port;
    return ($p0 == $side1) ? $p1 : $p0;
}

sub bridge_weight($bridge) {
    return sum(map { $weight{$_} } @$bridge);
}
