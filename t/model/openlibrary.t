#!/usr/bin/env perl
use Modern::Perl;
use IO::Socket::IP;
use Test::More;
use Test::Exception;

BEGIN {
  plan skip_all => 'Needs access to OpenLibrary API endpoint'
    unless IO::Socket::IP->new(PeerHost => 'openlibrary.org:https');

  plan tests => 10;

  use_ok('Model::OpenLibrary') or BAIL_OUT "Can't find an open library";
}

my $model = new_ok('Model::OpenLibrary');

can_ok($model, qw(covers_for_title));
dies_ok { $model->covers_for_title('') } 'needs title to search';

my $result;
lives_ok { $result = $model->covers_for_title('perl') }
'got results for "perl"';

is(ref $result, 'ARRAY', 'got results in arrayref');
note explain $result;
for my $key (qw(id title url link)) {
  ok($result->[0]{$key}, "first result has key $key");
}
