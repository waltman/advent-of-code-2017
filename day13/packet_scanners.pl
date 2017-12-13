#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

my @fw;

# parse the input
while (<>) {
    chomp;
    /(\d+): (\d+)/;
    $fw[$1] = $2;
}

# compute severity
my $severity = 0;
my @pos = map {0} 0..$#fw;
my @dir = map {1} 0..$#fw;
for my $i (0..$#fw) {
#    say "$i: @pos";
    if (defined $fw[$i] && $pos[$i] == 0) {
#        say "$i";
        $severity += $i * $fw[$i];
    }
    for my $j (0..$#fw) {
        next unless defined $fw[$j];
        $pos[$j] += $dir[$j];
        if ($pos[$j] == $fw[$j]-1) {
            $dir[$j] = -1;
        } elsif ($pos[$j] == 0) {
            $dir[$j] = 1;
        }
    }
}
# for my $i (1..$#fw) {
#     if (defined $fw[$i] && ($i % ($fw[$i]-1) * 2) == 0) {
#         say "i = $i, fw[i] = $fw[$i], severity = ", $i * $fw[$i];
#         $severity += $i * $fw[$i];
#     }
# }

say "result1: $severity";

# now let's try to get through without getting caught!
my $delay = 0;
my $ok = 0;
until ($ok) {
    my @pos = map {0} 0..$#fw;
    my @dir = map {1} 0..$#fw;
    # delay $delay steps
    for my $i (1..$delay) {
        for my $j (0..$#fw) {
            next unless defined $fw[$j];
            $pos[$j] += $dir[$j];
            if ($pos[$j] == $fw[$j]-1) {
                $dir[$j] = -1;
            } elsif ($pos[$j] == 0) {
                $dir[$j] = 1;
            }
        }
    }

    # can we get through?
    my $caught = 0;
    for my $i (0..$#fw) {
        if (defined $fw[$i] && $pos[$i] == 0) {
            $caught = 1;
            say "delay $delay, caught at pos $i";
            last;
        }
        for my $j (0..$#fw) {
            next unless defined $fw[$j];
            $pos[$j] += $dir[$j];
            if ($pos[$j] == $fw[$j]-1) {
                $dir[$j] = -1;
            } elsif ($pos[$j] == 0) {
                $dir[$j] = 1;
            }
        }
    }
    if ($caught) {
        $delay++;
    } else {
        $ok = 1;
    }
}

say "result2: $delay";
