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
for my $i (0..$#fw) {
    $severity += $i * $fw[$i] if caught(\@fw, $i)
}

say "result1: $severity";

# now let's try to get through without getting caught!
my $delay = 0;
my $ok = 0;
while (!$ok) {
    $ok = 1;
    for my $i (0..$#fw) {
        if (caught(\@fw, $i, $delay)) {
            $ok = 0;
            last;
        }
    }
    $delay++ unless $ok;
}

say "result2: $delay";

sub caught($fw, $i, $delay = 0) {
    return (defined $fw->[$i] && ($delay+$i) % (2 * ($fw->[$i]-1)) == 0);
}
