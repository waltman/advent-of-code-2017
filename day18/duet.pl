#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

my %r = map { $_ => 0 } 'a'..'z';
$r{snd} = 'nil';
$r{rcv} = 'nil';
my @pgm;

# parse the input and construct an array of closures
while (<>) {
    chomp;
    my @tok = split ' ';
    if ($tok[0] eq 'set') {
        push @pgm, sub ($ip, $r) {
            my $val = $tok[2] =~ /\d+/ ? $tok[2] : $r->{$tok[2]};
            $r->{$tok[1]} = $val;
            return $ip+1;
        }
    } elsif ($tok[0] eq 'add') {
        push @pgm, sub ($ip, $r) {
            my $val = $tok[2] =~ /\d+/ ? $tok[2] : $r->{$tok[2]};
            $r->{$tok[1]} += $val;
            return $ip+1;
        }
    } elsif ($tok[0] eq 'mul') {
        push @pgm, sub ($ip, $r) {
            my $val = $tok[2] =~ /\d+/ ? $tok[2] : $r->{$tok[2]};
            $r->{$tok[1]} *= $val;
            return $ip+1;
        }
    } elsif ($tok[0] eq 'mod') {
        push @pgm, sub ($ip, $r) {
            my $val = $tok[2] =~ /\d+/ ? $tok[2] : $r->{$tok[2]};
            $r->{$tok[1]} %= $val;
            return $ip+1;
        }
    } elsif ($tok[0] eq 'snd') {
        push @pgm, sub ($ip, $r) {
            $r->{snd} = $r->{$tok[1]};
            return $ip+1;
        }
    } elsif ($tok[0] eq 'rcv') {
        push @pgm, sub ($ip, $r) {
            if ($r->{$tok[1]} != 0 ) {
                $r->{rcv} = $r->{snd};
                return -1;
            } else {
                return $ip+1;
            }
        }
    } elsif ($tok[0] eq 'jgz') {
        push @pgm, sub ($ip, $r) {
            if ($r->{$tok[1]} > 0) {
                return $ip + $tok[2];
            } else {
                return $ip+1;
            }
        }
    }
}

# run the program
my $ip = 0;
while ($ip >= 0 && $ip < @pgm) {
    $ip = $pgm[$ip]->($ip, \%r);
}
say "result1: $r{rcv}";
