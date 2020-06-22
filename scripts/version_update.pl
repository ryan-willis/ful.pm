#!/usr/bin/env/perl

use Path::Tiny;
use Getopt::Long;

my $ACME_FUL_PATH = 'lib/Acme/ful.pm';
my $FUL_PATH      = 'lib/ful.pm';
my $README        = 'README.pod';
my $MAKEFILE      = 'Makefile.PL';

GetOptions(my $opt = {
    to => undef,
}, 'to=s');

die 'no -to options specified' unless $opt->{to};

my $git = path(__FILE__)->absolute->parent->parent;

my $pod     = $git->child($README)->slurp_utf8;
my $acmeful = $git->child($ACME_FUL_PATH)->slurp_utf8;
my $ful     = $git->child($FUL_PATH)->slurp_utf8;
my $mkfile  = $git->child($MAKEFILE)->slurp_utf8;

my ($cur) = $acmeful =~ /.*our \$VERSION = '(.+)'.+/g;

$ful     =~ s/\Q$cur\E/$opt->{to}/g;
$pod     =~ s/\Q$cur\E/$opt->{to}/g;
$acmeful =~ s/\Q$cur\E/$opt->{to}/g;
$mkfile  =~ s/\Q$cur\E/$opt->{to}/g;

$git->child($README)->spew_utf8($pod);
$git->child($ACME_FUL_PATH)->spew_utf8($acmeful);
$git->child($FUL_PATH)->spew_utf8($ful);
$git->child($MAKEFILE)->spew_utf8($mkfile);