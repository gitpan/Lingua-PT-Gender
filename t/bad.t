#!/usr/bin/perl

use Test::More tests => 189;

use strict;
use Lingua::PT::Gender qw/ptbr_gender/;

my $fname=shift || "bad.txt";
open(FH,$fname) || open(FH,"t/$fname") || die "Can't open test file '$fname'";

while (<FH>)
{
    my ($stated_gender) = /(.)[\n\r]*$/o;
    my ($computed_gender) = ptbr_gender($_) ? "M" : "F";
    ok($stated_gender ne $computed_gender);
}

close(FH);
