#!/usr/bin/env perl

use strict;
use warnings;

open(my $fh, "<", "./zzabezp.xml") or die $!;

local $/;
my $blob = <$fh>;
$blob =~ s{
    (<\s*number\s*>\s*)
        (\d{6}) (\d+) (\d{4})
    (\s*<\s*/\s*number\s*>)
}{$1 . $2 . ("*" x length $3) . $4 . $5}ex or die "bledny format numeru\n";
$blob =~ s{
    (<\s*cvc\s*>\s*)
        (\d+)
    (\s*<\s*/\s*cvc\s*>)
}{$1 . ("*" x length $2) . $3}ex or die "bledny format cvc\n";
print $blob;

