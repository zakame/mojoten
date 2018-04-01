#!/usr/bin/env perl
use Modern::Perl;
use IO::Socket::IP;
use Test::More;
use Test::Exception;

my $config;

BEGIN {
  plan skip_all => 'Needs access to Random.org'
    unless IO::Socket::IP->new(PeerHost => 'api.random.org:https');

  $config = do './mojoten.test.conf';
  if ($config->{randomorg}{key} or $ENV{RANDOMORG_API_KEY}) {
    plan tests => 11;
  }
  else {
    plan skip_all => 'Needs Random.org API key';
  }

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
  'Model::RandomNumber for integer result but no API key');
dies_ok { $model->generate(integer => 1) } 'no API key set';

$args = [lower => 0, upper => 9, key => $config->{randomorg}{key}];
$model = new_ok('Model::RandomNumber', $args,
  'Model::RandomNumber for integer result');
ok(
  $model->generate(integer => 1) =~ /^[0-9]$/,
  'random number from default, integer result'
);
dies_ok { $model->generate(foo => 'bar') } 'generate with bogus args';
