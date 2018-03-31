#!/usr/bin/env perl
use Mojo::Base -strict;

use Test::More tests => 13;
use Test::Mojo;
use Model::RandomNumber;
use Test::MockModule;

BEGIN { use_ok 'Mojoten' or BAIL_OUT "Mojoten is broken" }

my $mock = Test::MockModule->new('Model::RandomNumber');

my $t = Test::Mojo->new('Mojoten');
$t->get_ok('/randomnumber')->status_is(200)->content_like(qr/Random Number/i);

$mock->mock(generate => sub { 0.123456789 });
$t->get_ok('/randomnumber/get')->status_is(200)->content_like(qr/^0\.[0-9]+/);

$mock->mock(generate => sub { 4 });
$t->get_ok('/randomnumber/d6')->status_is(200)->content_like(qr/[1-6]/);

$mock->mock(generate => sub { die });
$t->get_ok('/randomnumber/get')->status_is(400)->content_like(qr/Bad request/i);
