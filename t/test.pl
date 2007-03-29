#!/usr/bin/perl

use strict;
use Lingua::PT::Gender qw/ptbr_gender/;

my $fname=shift || "good.txt";
open(FH,$fname) || die "Can't open test file '$fname'";

my ($noks,$nitems);
while (<FH>)
{
    my ($stated_gender) = /(.)[\n\r]*$/o;
    my ($computed_gender) = ptbr_gender($_) ? "M" : "F";
    $nitems++;
   
    if ($stated_gender eq $computed_gender) {
        $noks++;
    } else {
        #print $_;
        print "$.: $_";
    }
}

close(FH);

print "\nnitems=$nitems, noks=$noks ";
printf("(%6.2f%%)",$noks*100.0/$nitems);
print ", wrongs=", ($nitems-$noks), "\n";

