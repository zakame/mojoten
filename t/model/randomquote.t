#!/usr/bin/env perl
use strict;
use warnings;

use Test::More tests => 3;

BEGIN {
  use_ok('Model::RandomQuote') or BAIL_OUT "Can't get random quotes";
}

ok(Model::RandomQuote::get_one());
ok(Model::RandomQuote::get_all());
