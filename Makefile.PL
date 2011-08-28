#!/usr/bin/env perl

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojoten',
  VERSION      => '0.01',
  AUTHOR       => 'Zak B. Elep <zakame@cpan.org>',
  EXE_FILES    => ['script/mojoten'],
  PREREQ_PM    => {
    'Mojolicious'      => '1.80',
    'Modern::Perl'     => 0,
    'Astro::MoonPhase' => 0,
    'Date::Manip    '  => 0,
    'Try::Tiny'        => 0
  },
  test => {TESTS => 't/*.t'}
);
