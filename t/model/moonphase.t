#!/usr/bin/env perl
use Modern::Perl;
use Astro::MoonPhase;
use Time::ParseDate;
use Test::More tests => 5;

BEGIN {
  use_ok('Model::MoonPhase', qw(illumination is_waxing))
    or BAIL_OUT "Can't see the moon in cloudy skies";
}

my $time = "42 days ago at 5pm";
is_deeply(
  [Model::MoonPhase::moonphase($time)],
  [phase(parsedate($time))],
  "correct moon phase"
);

my @phase = Model::MoonPhase::moonphase($time);
is(illumination($time),          $phase[1], "correct moon illumination");
is(Model::MoonPhase::age($time), $phase[2], "correct moon age");
is(is_waxing($time), $phase[2] < (29.53 / 2), "moon is/is not waxing");
