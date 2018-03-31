#!/usr/bin/env perl
use strict;
use warnings;

use Test::More tests => 9;
use Test::Exception;

BEGIN {
  use_ok('Model::RandomNumber') or BAIL_OUT "Can't get random numbers";
}

my $model = new_ok('Model::RandomNumber');
can_ok($model, qw(generate));
ok($model->generate < 1, 'random number from default parameters (0, 1)');

my $args = [upper => 1, lower => 2];
$model
  = new_ok('Model::RandomNumber', $args, 'Model::RandomNumber with bad args');
dies_ok { $model->generate } 'lower greater than upper';

$args = [lower => 0, upper => 9];
$model = new_ok('Model::RandomNumber', $args,
  'Model::RandomNumber for integer result');
ok(
  $model->generate(integer => 1) =~ /^[0-9]$/,
  'random number from default, integer result'
);
dies_ok { $model->generate(foo => 'bar') } 'generate with bogus args';
