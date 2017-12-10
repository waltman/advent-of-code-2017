#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.24);
use experimental qw(signatures);

# test data
#my @list = 0..4;
#my $LENS = "3,4,1,5";


# problem data
my @list = 0..255;
my $LENS = "147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70";
my @STD_SUFFIX = (17, 31, 73, 47, 23);
my @LENS = map {ord} split //, $LENS;
push @LENS, @STD_SUFFIX;

my $p = 0;
my $skip = 0;

for my $round (1..64) {
    for my $len (@LENS) {
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

print "result2: ";
printf "%02x", $_ for @dense;
print "\n";
