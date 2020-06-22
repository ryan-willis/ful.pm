#!/usr/bin/perl

use Path::Tiny;

my $FUL_PATH = 'lib/ful.pm';
my $README   = 'README.pod';

my $git = path(__FILE__)->absolute->parent->parent;

my $pod = $git->child($README)->slurp_utf8;
my $ful = $git->child($FUL_PATH)->slurp_utf8;

$ful =~ s/=pod\n\n.*\n\n=cut/=pod\n\n$pod\n\n=cut/gs;

$git->child($FUL_PATH)->spew_utf8($ful);