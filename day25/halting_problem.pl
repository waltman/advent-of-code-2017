#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);
use List::Util qw(sum);

# parse out the turing machine
my %pgm;
my $max_steps;
my $init_state;
$/ = "\n\n";

while (<>) {
    if (substr($_, 0, 1) eq 'B') {
        /state (.).*after (\d+)/s;
        $init_state = $1;
        $max_steps = $2;
    } else {
        /In state (.):
  If the current value is 0:
    - Write the value (\d)\.
    - Move one slot to the ([^.]+)\.
    - Continue with state (.)\.
  If the current value is 1:
    - Write the value (\d)\.
    - Move one slot to the ([^.]+)\.
    - Continue with state (.)\./s;
        my ($state, $w0, $m0, $c0, $w1, $m1, $c1) = ($1, $2, $3, $4, $5, $6, $7);
        my $d0 = $m0 eq 'left' ? -1 : 1;
        my $d1 = $m1 eq 'left' ? -1 : 1;
        $pgm{$state} = sub ($ip, $tape) {
            if ($tape->[$ip] == 0) {
                $tape->[$ip] = $w0;
                return ($ip + $d0, $c0);
            } else {
                $tape->[$ip] = $w1;
                return ($ip + $d1, $c1);
            }
        }
    }
}

my $TAPELEN = 12000;
my $state = $init_state;
my @tape = map {0} 1..$TAPELEN;
my $ip = $TAPELEN/2;

for my $step (1..$max_steps) {
    ($ip, $state) = $pgm{$state}->($ip, \@tape);
    if ($ip < 0 || $ip >= $TAPELEN) {
        die "ip = $ip on step $step, aborting...";
    }
}

say "result1: ", sum(@tape);
