package Mojoten::Controller::MoonPhase;
use Mojo::Base 'Mojolicious::Controller';
no indirect;

use Try::Tiny;

use Model::MoonPhase qw(illumination is_waxing);

sub index { }

sub check {
  my $self = shift;
  my $time = $self->req->json('/time') || $self->param('time') || 'now';

  try {
    my $i = illumination($time) * 100;
    my $r = {
      time        => $time,
      illuminated => sprintf("%.1f", $i),
      phase       => is_waxing($time) ? 'waxing' : 'waning'
    };
    $self->respond_to(
      json => {json     => $r},
      html => {template => 'moon_phase/result', result => $r},
    );
  }
  catch {
    my $e = "What, that's no date or time I can recognize!";
    $self->respond_to(
      json => {json => {error => $e}},
      html => {template => 'moon_phase/result', result => $e},
    );
  };
}

1;
