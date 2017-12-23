#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

my %r = map { $_ => 0 } 'a'..'h';
$r{mul} = 0;
my @pgm;

# parse the input into an array of closures
while (<>) {
    chomp;
    my @tok = split / /;
    if ($tok[0] eq 'set') {
        push @pgm, sub ($ip, $r) {
            my $val = $tok[2] =~ /\d+/ ? $tok[2] : $r->{$tok[2]};
            $r->{$tok[1]} = $val;
            return $ip + 1;
        }
    } elsif ($tok[0] eq 'sub') {
        push @pgm, sub ($ip, $r) {
            my $val = $tok[2] =~ /\d+/ ? $tok[2] : $r->{$tok[2]};
            $r->{$tok[1]} -= $val;
            return $ip + 1;
        }
    } elsif ($tok[0] eq 'mul') {
        push @pgm, sub ($ip, $r) {
            my $val = $tok[2] =~ /\d+/ ? $tok[2] : $r->{$tok[2]};
            $r->{$tok[1]} *= $val;
            $r->{mul}++;
            return $ip + 1;
        }
    } elsif ($tok[0] eq 'jnz') {
        push @pgm, sub ($ip, $r) {
            my $val1 = $tok[1] =~ /([a-z])/ ? $r->{$tok[1]} : $tok[1];
            my $val2 = $tok[2] =~ /([a-z])/ ? $r->{$tok[2]} : $tok[2];
            if ($val1 != 0) {
                return $ip + $val2;
            } else {
                return $ip+1;
            }
        }
    } else {
        say "WTF? $_";
    }
}

# run the program
my $ip = 0;
my $cnt = 0;
$r{a} = 0;
while ($ip >= 0 && $ip < @pgm) {
    $ip = $pgm[$ip]->($ip, \%r);
    $cnt++;
}

say "result1: $r{mul}";

say "$cnt steps";
say "registers:";
say "$_, $r{$_}" for 'a'..'h';
