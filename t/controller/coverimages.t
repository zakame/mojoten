#!/usr/bin/env perl
use Mojo::Base -strict;

use Test::More tests => 24;
use Test::Mojo;
use Model::OpenLibrary;
use Test::MockModule;

BEGIN { use_ok 'Mojoten' or BAIL_OUT "Mojoten is broken" }

my $result = [
  {
    id    => 154155,
    title => 'Programming Perl',
    url   => 'https://images.gr-assets.com/books/1328835945m/154155.jpg'
  },
  {
    id    => 852918,
    title => 'Programming the Perl DBI',
    url   => 'https://images.gr-assets.com/books/1328752770m/852918.jpg'
  },
  {
    id    => 86368,
    title => 'Elements of Programming with Perl',
    url   => 'https://images.gr-assets.com/books/1328699492m/86368.jpg'
  }
];


my $mock = Test::MockModule->new('Model::OpenLibrary');
$mock->mock(covers_for_title => sub {$result});

my $t = Test::Mojo->new('Mojoten');
$t->get_ok('/covers')->status_is(200)->content_like(qr/Cover Images/i);

$t->post_ok('/covers/title', form => {title => 'Programming Perl'})
  ->status_is(200)->content_type_like(qr#text/html#)
  ->element_exists('div.success')->content_like(qr/Programming the Perl DBI/)
  ->content_like(qr#1328699492m/86368.jpg#)->content_like(qr/Programming Perl/);

$t->post_ok('/covers/title',
  form => {title => 'Programming Perl with JSON', format => 'json'})
  ->status_is(200)->content_type_is('application/json;charset=UTF-8')
  ->json_is($result);

$mock->mock(covers_for_title => sub { die "testing controller\n" });

$t->post_ok('/covers/title', form => {title => ''})->status_is(200)
  ->content_type_like(qr#text/html#)->element_exists('div.error')
  ->content_like(qr/Something went wrong/);

$t->post_ok('/covers/title', form => {title =>'', format => 'json'})
    ->status_is(200)->content_type_is('application/json;charset=UTF-8')
    ->json_is( {error => 'Something went wrong. Try again.'});
