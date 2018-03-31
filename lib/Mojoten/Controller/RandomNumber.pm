package Mojoten::Controller::RandomNumber;
use Mojo::Base 'Mojolicious::Controller';
no indirect;

use Try::Tiny;

use Model::RandomNumber;

has model => sub {
  state $m = Model::RandomNumber->new;
};

sub index { }

sub get {
  my $self = shift;

  my $lower = $self->req->json('/lower')   || $self->param('lower')   || 0;
  my $upper = $self->req->json('/upper')   || $self->param('upper')   || 1;
  my $int   = $self->req->json('/integer') || $self->param('integer') || 0;

  try {
    $self->render(
      text => $self->model->tap(lower => $lower)->tap(upper => $upper)
        ->generate(integer => $int));
  }
  catch {
    $self->app->log->error($_);
    $self->render(text => 'Bad request', status => 400);
  };
}

1;
