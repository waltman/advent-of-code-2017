#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

my %r0 = map { $_ => 0 } 'a'..'z';
my %r1 = map { $_ => 0 } 'a'..'z';
$r1{p} = 1;
$r1{sent} = 0;
$r1{pid1} = 1;
my @pgm0;
my @pgm1;

# parse the input and construct an array of closures
while (<>) {
    chomp;
    my @tok = split ' ';
    if ($tok[0] eq 'set') {
        push @pgm0, sub ($ip, $r, $q) {
            my $val = $tok[2] =~ /\d+/ ? $tok[2] : $r->{$tok[2]};
            $r->{$tok[1]} = $val;
            return $ip+1;
        }
    } elsif ($tok[0] eq 'add') {
        push @pgm0, sub ($ip, $r, $q) {
            my $val = $tok[2] =~ /\d+/ ? $tok[2] : $r->{$tok[2]};
            $r->{$tok[1]} += $val;
            return $ip+1;
        }
    } elsif ($tok[0] eq 'mul') {
        push @pgm0, sub ($ip, $r, $q) {
            my $val = $tok[2] =~ /\d+/ ? $tok[2] : $r->{$tok[2]};
            $r->{$tok[1]} *= $val;
            return $ip+1;
        }
    } elsif ($tok[0] eq 'mod') {
        push @pgm0, sub ($ip, $r, $q) {
            my $val = $tok[2] =~ /\d+/ ? $tok[2] : $r->{$tok[2]};
            $r->{$tok[1]} %= $val;
            return $ip+1;
        }
    } elsif ($tok[0] eq 'jgz') {
        push @pgm0, sub ($ip, $r, $q) {
            my $val1 = $tok[1] =~ /([a-z])/ ? $r->{$tok[1]} : $tok[1];
            my $val2 = $tok[2] =~ /([a-z])/ ? $r->{$tok[2]} : $tok[2];
            if ($val1 > 0) {
                return $ip + $val2;
            } else {
                return $ip+1;
            }
        }
    } elsif ($tok[0] eq 'snd') {
        push @pgm0, sub ($ip, $r, $q) {
            $r->{sent}++ if defined $r->{pid1};
            return ($ip+1, $r->{$tok[1]});
        }
    } elsif ($tok[0] eq 'rcv') {
        push @pgm0, sub ($ip, $r, $q) {
            if (@$q) {
                $r->{$tok[1]} = shift @$q;
                return $ip+1;
            } else {
                return $ip;
            }
        }
    }
    push @pgm1, $pgm0[-1];
}

# run the program
my $ip0 = 0;
my $ip1 = 0;
my $dead = 0;
my @q0 = ();
my @q1 = ();
while ($ip0 >= 0 && $ip0 < @pgm0 && $ip1 >= 0 && $ip1 < @pgm1 && !$dead) {
    my ($ip0a, $val0) = $pgm0[$ip0]->($ip0, \%r0, \@q0);
    push @q1, $val0 if defined $val0;

    my ($ip1a, $val1) = $pgm1[$ip1]->($ip1, \%r1, \@q1);
    push @q0, $val1 if defined $val1;

    if ($ip0a == $ip0 && $ip1a == $ip1 && !@q0 && !@q1) {
        $dead = 1;
    } else {
        $ip0 = $ip0a;
        $ip1 = $ip1a;
    }
}

say "result2: $r1{sent}";
