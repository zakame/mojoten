package Mojo::TenInTen::RandomQuote;
use Mojo::Base 'Mojolicious::Controller';
use Model::RandomQuote;

sub index { }

sub quote {
  my $self  = shift;
  my $quote = Model::RandomQuote::get_one;
  $self->render(json => $quote);
}

sub show_all {
  my $self   = shift;
  my @quotes = Model::RandomQuote::get_all;
  $self->render(json => \@quotes);
}

1;
