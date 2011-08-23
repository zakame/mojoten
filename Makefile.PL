#!/usr/bin/env perl

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojo::TenInTen',
  VERSION_FROM => 'lib/Mojo/TenInTen.pm',
  AUTHOR       => 'Zak B. Elep <zakame@cpan.org>',
  EXE_FILES    => ['script/mojo_ten_in_ten'],
  PREREQ_PM    => {
    'Mojolicious'      => '1.80',
    'Modern::Perl'     => 0,
    'Astro::MoonPhase' => 0,
    'Time::ParseDate'  => 0,
    'Try::Tiny'        => 0
  },
  test => {TESTS => 't/*.t'}
);
