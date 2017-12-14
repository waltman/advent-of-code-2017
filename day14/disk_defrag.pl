#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);
use List::Util qw(sum);
use Graph::Undirected;

my $key = $ARGV[0];
my $total = 0;
my @disk;
for my $i (0..127) {
    my $hash = knot_hash("$key-$i");
    $total += sum @$hash;
    push @disk, $hash;
}

say "result1: $total";

my $g = Graph::Undirected->new;
# add vertex for each used square
for my $r (0..127) {
    for my $c (0..127) {
        $g->add_vertex("$r,$c") if $disk[$r][$c];
    }
}

# rows
for my $r (0..127) {
    for my $c (0..126) {
        if ($disk[$r][$c] && $disk[$r][$c+1]) {
            my $from = "$r,$c";
            my $to = sprintf "%d,%d", $r, $c+1;
            $g->add_edge($from, $to);
        }
    }
}
# cols
for my $r (0..126) {
    for my $c (0..127) {
        if ($disk[$r][$c] && $disk[$r+1][$c]) {
            my $from = "$r,$c";
            my $to = sprintf "%d,%d", $r+1, $c;
            $g->add_edge($from, $to);
        }
    }
}
my @cc = $g->connected_components();
say "result2: ", scalar @cc;

sub knot_hash($lens) {

    my @list = 0..255;
    my @STD_SUFFIX = (17, 31, 73, 47, 23);
    my @lens = map {ord} split //, $lens;
    push @lens, @STD_SUFFIX;

    my $p = 0;
    my $skip = 0;

    for my $round (1..64) {
        for my $len (@lens) {
            my $end = $p + $len - 1;
            if ($end <= $#list) {
                @list[$p..$end] = reverse @list[$p..$end];
            } else {
                my @tmp = (@list, @list);
                @tmp[$p..$end] = reverse @tmp[$p..$end];
                @tmp[0..($end-$#list-1)] = @tmp[$#list+1..$end];
                @list = @tmp[0..$#list];
            }
            $p = ($p + $len + $skip) % @list;
            $skip++;
        }
    }

    # compute dense hash from @list
    my @dense;
    for (my $i = 0; $i < 256; $i += 16) {
        my $out = $list[$i];
        for my $j ($i+1..$i+15) {
            $out ^= $list[$j];
        }
        push @dense, $out;
    }
    my $hash;
    $hash .= sprintf "%08b", $_ for @dense;
    return [split //, $hash];
}

