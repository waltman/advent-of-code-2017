package Particle;

use strict;
use warnings;
use Carp;
use feature qw(:5.24);
use experimental qw(signatures);

sub new($package, $line) {
    my $self = {};
    bless $self, $package;

    $self->_init($line);
    return $self;
}

sub _init($self, $line) {
    my @tok = split ", ", $line;
    my ($x, $y, $z);

    ($x, $y, $z) = $self->_parse($tok[0]);
    $self->{px} = $x;
    $self->{py} = $y;
    $self->{pz} = $z;

    ($x, $y, $z) = $self->_parse($tok[1]);
    $self->{vx} = $x;
    $self->{vy} = $y;
    $self->{vz} = $z;

    ($x, $y, $z) = $self->_parse($tok[2]);
    $self->{ax} = $x;
    $self->{ay} = $y;
    $self->{az} = $z;

    $self->{hit} = 0;
}

sub _parse($self, $tok) {
    $tok =~ s/[^\d\-,]//g;
    my ($x, $y, $z) = split /,/, $tok;
    return ($x, $y, $z);
}

sub dump($self) {
    return sprintf "p=(%d,%d,%d), v=(%d,%d,%d), a=(%d,%d,%d), d=%d",
        $self->{px}, $self->{py}, $self->{pz},
        $self->{vx}, $self->{vy}, $self->{vz},
        $self->{ax}, $self->{ay}, $self->{az},
        $self->dist();
}

sub tick($self) {
    $self->{vx} += $self->{ax};
    $self->{vy} += $self->{ay};
    $self->{vz} += $self->{az};

    $self->{px} += $self->{vx};
    $self->{py} += $self->{vy};
    $self->{pz} += $self->{vz};
}

sub dist($self) {
    return abs($self->{px}) + abs($self->{py}) + abs($self->{pz});
}

sub accel_mag($self) {
    return abs($self->{ax}) + abs($self->{ay}) + abs($self->{az});
}

sub pos($self) {
    return ($self->{px}, $self->{py}, $self->{pz});
}

sub collision($self, $p) {
    my ($px, $py, $pz) = $p->pos();
    return $self->{px} == $px && $self->{py} == $py && $self->{pz} == $pz;
}

sub set_hit($self, $val) {
    $self->{hit} = $val;
}

sub unhit($self) {
    return $self->{hit} == 0;
}

1;
