#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

my %parent;
my %children;
my %weight;

# parse the input
while (<>) {
    chomp;
    my @token = split / -> /;
    $token[0] =~ /^([a-z]+) \((\d+)/;
    my $name = $1;
    my $weight = $2;
    $weight{$name} = $weight;
    if (defined $token[1]) {
        my @disk = split ', ', $token[1];
        for my $disk (@disk) {
            $parent{$disk} = $name;
            push @{$children{$name}}, $disk;
        }
    }
}

# find the root
my @keys = keys %parent;
my $root = $keys[0];
$root = $parent{$root} while defined $parent{$root};
say "result1: $root";

# find weights of root's subtrees
my @weights;
for my $subtree (@{$children{$root}}) {
    push @weights, tree_weight($subtree, \%children, \%weight);
}
my ($idx, $delta) = check_balance(\@weights);
say "weights = @weights";
say "delta = $delta";

# search for the bad disk
my $found = 0;
while (!$found) {
    $root = $children{$root}->[$idx];
    @weights = ();
    for my $subtree (@{$children{$root}}) {
        push @weights, tree_weight($subtree, \%children, \%weight);
    }
    say "@weights";
    my ($idx, undef)= check_balance(\@weights);
    if ($idx == -1) {
        say "result2: ", $weight{$root} + $delta;
        $found = 1;
    } else {
        say "not found, checking $children{$root}->[$idx]";
    }
}

sub tree_weight($root, $children, $weight) {
    my $sum = $weight->{$root};
    for my $t (@{$children->{$root}}) {
        $sum += tree_weight($t, $children, $weight);
    }
    return $sum;
}

sub check_balance($weights) {
    my %h;

    for my $i (0..$#$weights) {
        my $w = $weights->[$i];
        push @{$h{$w}}, $i;
    }

    my @k = keys %h;
    my @size = map { scalar @{$h{$_}} } @k;
    say "@k";
    say "@size";
    my ($idx, $delta);
    if (@k == 1) { # balanced
        ($idx, $delta) = (-1, -1);
    } else {
        if ($size[0] == 1) {
            $idx = $h{$k[0]}->[0];
            $delta = $k[1] - $k[0];
        } else {
            $idx = $h{$k[1]}->[0];
            $delta = $k[0] - $k[1];
        }
        say "idx = $idx, delta = $delta";
        return ($idx, $delta);
    }
}
