#!/usr/bin/env perl

use strict;
use warnings;

use Class::MOP;

my $class = shift;
Class::MOP::load_class($class);
die "$class is not runnable" unless $class->does('MooseX::Runnable');
$class->run_as_application;
