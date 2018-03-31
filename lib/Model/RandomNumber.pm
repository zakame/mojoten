package Model::RandomNumber;
use strict;
use warnings;
use Carp;

sub new {
  my $self = shift;
  my %args = @_;
  bless {lower => $args{lower} || 0, upper => $args{upper} || 1} => $self;
}

sub generate {
  my ($self, %args) = @_;

  my $integer = delete $args{integer} // '';

  croak 'unsupported args or combination of args', join ', ' => %args
    if keys %args;

  croak 'upper bound not greater than lower bound'
    unless $self->{upper} > $self->{lower};

  my $range = $self->{upper} - $self->{lower};
  $integer
    ? int(rand($range) + $self->{lower} + 0.5 * ($range <=> 0))
    : rand($range) + $self->{lower};
}

1;
