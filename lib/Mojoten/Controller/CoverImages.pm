package Mojoten::Controller::CoverImages;
use Mojo::Base 'Mojolicious::Controller';
no indirect;

use Try::Tiny;

use Model::Goodreads;

has model => sub {
  state $m = Model::Goodreads->new(key => shift->app->config->{goodreads}{key});
};

sub index { }

sub get_covers {
  my $self = shift;
  my $title
    = $self->req->json('/title') || $self->param('title') || 'Programming Perl';

  my $r;
  try {
    $self->app->log->debug("title: $title");
    $r = $self->model->covers_for_title($title);
    $self->respond_to(
      json => {json     => $r},
      html => {template => 'cover_images/result', result => $r},
    );
  }
  catch {
    $self->app->log->error("CoverImages: $_");
    my $e = "Something went wrong. Try again.";
    $self->respond_to(
      json => {json => {error => $e}},
      html => {template => 'cover_images/result', result => $e},
    );
  };
}

1;
