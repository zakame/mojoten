package Mojo::TenInTen::MoonPhase;
use Mojo::Base 'Mojolicious::Controller';

use Model::MoonPhase qw(illumination is_waxing);
use Try::Tiny;

sub index { }

sub check {
  my $self = shift;
  my $time = $self->param('time') || 'now';

  try {
    my $i = illumination($time) * 100;
    $self->render(
      json => {
        time        => $time,
        illuminated => sprintf("%.1f", $i),
        phase       => is_waxing($time) ? 'waxing' : 'waning'
      }
    );
  }
  catch { $self->render_exception("Server Error: $_") };
}

1;
