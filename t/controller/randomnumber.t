#!/usr/bin/env perl
use Mojo::Base -strict;

use Test::More tests => 10;
use Test::Mojo;

BEGIN { use_ok 'Mojoten' or BAIL_OUT "Mojoten is broken" }

my $t = Test::Mojo->new('Mojoten');
$t->get_ok('/randomnumber')->status_is(200)->content_like(qr/Random Number/i);

$t->get_ok('/randomnumber/get')->status_is(200)->content_like(qr/^0\.[0-9]+/);

$t->get_ok('/randomnumber/d6')->status_is(200)->content_like(qr/[1-6]/);
