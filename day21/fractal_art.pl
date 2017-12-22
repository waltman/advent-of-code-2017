#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

my $ITER = shift @ARGV;

# parse the rules
my %rule;
while (<>) {
    chomp;
    my ($from, $to) = split / => /;
    my $g = rule2g($from);
    if (length($from) == 5) {
        for my $i (1..4) {
            $rule{g2rule($g)} = $to;
            $rule{g2rule(flip2($g))} = $to;
            $g = rot2($g);
        }
    } else {
        for my $i (1..4) {
            $rule{g2rule($g)} = $to;
            $rule{g2rule(flip3($g))} = $to;
            $g = rot3($g);
        }
    }
}

my $g = rule2g('.#./..#/###');
for my $it (1..$ITER) {
    my $len = @$g;
    my $g2;
    if ($len % 2 == 0) {
        for (my $row = 0; $row < $len; $row += 2) {
            my $r2 = $row/2*3;
            for (my $col = 0; $col < $len; $col += 2) {
                my $c2 = $col/2*3;
                my $k = sprintf "%s%s/%s%s",
                    $g->[$row][$col],   $g->[$row][$col+1],
                    $g->[$row+1][$col], $g->[$row+1][$col+1];

                my $outg = rule2g($rule{$k});
                for my $i (0..2) {
                    for my $j (0..2) {
                        $g2->[$r2+$i][$c2+$j] = $outg->[$i][$j];
                    }
                }
            }
        }
    } else {
        for (my $row = 0; $row < $len; $row += 3) {
            my $r2 = $row/3*4;
            for (my $col = 0; $col < $len; $col += 3) {
                my $c2 = $col/3*4;
                my $k = sprintf "%s%s%s/%s%s%s/%s%s%s",
                    $g->[$row][$col],   $g->[$row][$col+1],   $g->[$row][$col+2],
                    $g->[$row+1][$col], $g->[$row+1][$col+1], $g->[$row+1][$col+2],
                    $g->[$row+2][$col], $g->[$row+2][$col+1], $g->[$row+2][$col+2];

                my $outg = rule2g($rule{$k});
                for my $i (0..3) {
                    for my $j (0..3) {
                        $g2->[$r2+$i][$c2+$j] = $outg->[$i][$j];
                    }
                }
            }
        }
    }
    $g = $g2;
}

my $cnt = 0;
my $len = @$g;
for my $row (0..$len-1) {
    for my $col (0..$len-1) {
        $cnt++ if $g->[$row][$col] eq '#';
    }
}

say "result: $cnt";
say "$len x $len";

sub flip2($g) {
    my @g2;
    $g2[0][0] = $g->[0][1];
    $g2[0][1] = $g->[0][0];
    $g2[1][0] = $g->[1][1];
    $g2[1][1] = $g->[1][0];

    return \@g2;
}

sub rot2($g) {
    my @g2;
    $g2[0][0] = $g->[1][0];
    $g2[0][1] = $g->[0][0];
    $g2[1][0] = $g->[1][1];
    $g2[1][1] = $g->[0][1];

    return \@g2;
}

sub flip3($g) {
    my @g3;
    $g3[0][0] = $g->[0][2];
    $g3[0][1] = $g->[0][1];
    $g3[0][2] = $g->[0][0];
    $g3[1][0] = $g->[1][2];
    $g3[1][1] = $g->[1][1];
    $g3[1][2] = $g->[1][0];
    $g3[2][0] = $g->[2][2];
    $g3[2][1] = $g->[2][1];
    $g3[2][2] = $g->[2][0];

    return \@g3;
}

sub rot3($g) {
    my @g3;
    $g3[0][0] = $g->[0][2];
    $g3[0][1] = $g->[1][2];
    $g3[0][2] = $g->[2][2];
    $g3[1][0] = $g->[0][1];
    $g3[1][1] = $g->[1][1];
    $g3[1][2] = $g->[2][1];
    $g3[2][0] = $g->[0][0];
    $g3[2][1] = $g->[1][0];
    $g3[2][2] = $g->[2][0];

    return \@g3;
}

sub printg($g) {
    for my $row (0..$#$g) {
        for my $col (0..$#$g) {
            print $g->[$row][$col];
        }
        print "\n";
    }
    print "\n";
}

sub g2rule($g) {
    my @rule = map { join "", @$_ } @$g;
    return join '/', @rule;
}

sub rule2g($rule) {
    my @line = split '/', $rule;
    my @g = map { [split //] } @line;
    return \@g;
}
