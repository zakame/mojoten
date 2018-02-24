#!/usr/bin/env perl
use Modern::Perl;
use Astro::MoonPhase;
use Date::Manip::Date;
use Test::More tests => 5;

BEGIN {
  use_ok('Model::MoonPhase', qw(illumination is_waxing))
    or BAIL_OUT "Can't see the moon in cloudy skies";
}

undef $::TZ;                    # silence Date::Manip::TZ warning

my $date = Date::Manip::Date->new;
my $time = "42 days ago at 5pm";
$date->parse($time);
is_deeply(
  [Model::MoonPhase::moonphase($time)],
  [phase($date->secs_since_1970_GMT)],
  "correct moon phase"
);

my @phase = Model::MoonPhase::moonphase($time);
is(illumination($time),          $phase[1], "correct moon illumination");
is(Model::MoonPhase::age($time), $phase[2], "correct moon age");
is(is_waxing($time), $phase[2] < (29.53 / 2), "moon is/is not waxing");
