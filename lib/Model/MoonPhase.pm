package Model::MoonPhase;
use Modern::Perl;
use Astro::MoonPhase;
use Time::ParseDate;
use Carp;

use Exporter 'import';
our @EXPORT_OK = qw(illumination is_waxing);

sub moonphase {
  my $raw_timish = shift;

  my ($time, $error) = parsedate($raw_timish);
  croak "Bad time: '$raw_timish' is not a recognized date/time" if $error;
  return phase($time);
}

sub illumination { [moonphase(shift)]->[1] }
sub age          { [moonphase(shift)]->[2] }
sub is_waxing    { age(shift) < (29.53 / 2) }

"Awoooooooooooooooooooooooo!";
