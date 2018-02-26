#!/usr/bin/env perl
use Mojo::Base -strict;

use Test::More tests => 3;
use Test::Mojo;

BEGIN { use_ok 'Mojoten' or BAIL_OUT "Mojoten is broken" }

my $t = Test::Mojo->new('Mojoten');
$t->get_ok('/randomquote/get_one');
$t->get_ok('/randomquote/get_all');
