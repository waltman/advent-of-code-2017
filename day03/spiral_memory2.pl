#!/usr/bin/env perl
use strict;
use warnings;
use feature ":5.26";
use experimental 'signatures';
use List::Util qw(min);
no warnings 'uninitialized';

my $target = $ARGV[0];
my $C = 10;
my @s;

$s[$C][$C] = 1;
$s[$C][$C+1] = 1;
my ($row, $col) = ($C, $C+1);
my ($dr, $dc) = (-1, 0); # up

while (1) {
    $row += $dr;
    $col += $dc;
    $s[$row][$col] = sum_adj(\@s, $row, $col);
    if ($s[$row][$col] > $target) {
        say "result2: $s[$row][$col]";
        last;
    }

    # change direction?
    if ($row == $col && $row < $C) { #nw
        ($dr, $dc) = (1, 0); # down
    } elsif ($row > $C && $row == $col-1) { #se
            ($dr, $dc) = (-1, 0); # up
    } elsif ($row-$C == $C-$col) {
        if ($row > $C) { #sw
            ($dr, $dc) = (0, 1) # right
        } else { #ne
            ($dr, $dc) = (0, -1) # left
        }
    }
}

for my $i (0..15) {
    for my $j (0..15) {
        print "$s[$i][$j]\t";
    }
    print "\n";
}

sub sum_adj($s, $r, $c) {
    return $s[$r-1][$c-1] + $s[$r-1][$c] + $s[$r-1][$c+1] +
           $s[$r][$c-1]                  + $s[$r][$c+1] +
           $s[$r+1][$c-1] + $s[$r+1][$c] + $s[$r+1][$c+1];
}
