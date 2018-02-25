#!/usr/bin/env perl
use Modern::Perl;
use IO::Socket::IP;
use Test::More;
use Test::Exception;

my $config;

BEGIN {
  plan skip_all => 'Needs access to Goodreads API endpoint'
    unless IO::Socket::IP->new(PeerHost => 'www.goodreads.com:https');

  $config = do './mojoten.test.conf';
  if ($config->{goodreads}{key} or $ENV{GOODREADS_API_KEY}) {
    plan tests => 13;
  }
  else {
    plan skip_all => 'Needs Goodreads API developer key';
  }

  use_ok('Model::Goodreads') or BAIL_OUT "Can't get a good read";
}

my $model = new_ok('Model::Goodreads');

can_ok($model, qw(covers_for_title));
dies_ok { $model->covers_for_title('perl') } 'needs auth with key';
dies_ok { $model->covers_for_title('') } 'needs title to search';

$model = new_ok(
  'Model::Goodreads',
  [key => $config->{goodreads}{key}],
  'Model::Goodreads with key'
);

my $result;
dies_ok { $result = $model->covers_for_title('') } 'needs title to search';
lives_ok { $result = $model->covers_for_title('perl') }
'got results for "perl"';

is(ref $result, 'ARRAY', 'got results in arrayref');
for my $key (qw(id title url)) {
  ok($result->[0]{$key}, "first result has key $key");
}

ok(grep(/Programming Perl/, map { $_->{title} } @$result),
  'got the Camel book');
