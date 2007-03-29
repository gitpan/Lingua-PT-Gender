#!/usr/bin/perl

use Test::More tests => 55826;

use strict;
use Lingua::PT::Gender qw/ptbr_gender/;

my $fname=shift || "good.txt";
open(FH,$fname) || open(FH,"t/$fname") || die "Can't open test file '$fname'";

while (<FH>)
{
    my ($stated_gender) = /(.)[\n\r]*$/o;
    my ($computed_gender) = ptbr_gender($_) ? "M" : "F";
    ok($stated_gender eq $computed_gender);
}

close(FH);
