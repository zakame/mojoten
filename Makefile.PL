#!/usr/bin/env perl

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojo::TenInTen',
  VERSION_FROM => 'lib/Mojo/TenInTen.pm',
  AUTHOR       => 'A Good Programmer <nospam@cpan.org>',
  EXE_FILES    => ['script/mojo_ten_in_ten'],
  PREREQ_PM    => {'Mojolicious' => '1.80', 'Modern::Perl' => 0},
  test         => {TESTS => 't/*.t'}
);
