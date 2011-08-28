package Model::MoonPhase;
use Modern::Perl;
use Astro::MoonPhase;
use Date::Manip::Date;
use Carp;

use Exporter 'import';
our @EXPORT_OK = qw(illumination is_waxing);

my $date = Date::Manip::Date->new;

sub moonphase {
  my $raw_timish = shift;

  my $err = $date->parse($raw_timish);
  croak "Bad time: '$raw_timish' is not a recognized date/time" if $err;
  return phase($date->secs_since_1970_GMT);
}

sub illumination { [moonphase(shift)]->[1] }
sub age          { [moonphase(shift)]->[2] }
sub is_waxing    { age(shift) < (29.53 / 2) }

"Awoooooooooooooooooooooooo!";
