#!/usr/bin/env perl
use Mojo::Base -strict;

use Test::More tests => 22;
use Test::Mojo;
use Model::MoonPhase qw(illumination is_waxing);

BEGIN { use_ok 'Mojoten' or BAIL_OUT "Mojoten is broken" }

my $t = Test::Mojo->new('Mojoten');
$t->get_ok('/moonphase')->status_is(200)->content_like(qr/Moon Phase/i);

my $time = "42 days ago at 7am";

# default output (HTML)
$t->post_ok('/moonphase/check', form => {time => $time})->status_is(200)
  ->content_type_like(qr#text/html#)->element_exists('div.success')
  ->content_like(qr/.+full/);
$t->post_ok('/moonphase/check', form => {time => 'fail'})->status_is(200)
  ->content_type_like(qr#text/html#)->element_exists('div.error')
  ->content_like(qr/no date or time I can recognize!/);

# REST output (JSON)
my $json = {
  time        => $time,
  illuminated => sprintf("%.1f", illumination($time) * 100),
  phase       => is_waxing($time) ? 'waxing' : 'waning'
};
$t->post_ok('/moonphase/check', form => {time => $time, format => 'json'})
  ->status_is(200)->content_type_is('application/json;charset=UTF-8')
  ->json_is($json);
$t->post_ok('/moonphase/check', form => {time => 'fail', format => 'json'})
  ->status_is(200)->content_type_is('application/json;charset=UTF-8')
  ->json_is(
  {error => "What, that's no date or time I can recognize!"});
