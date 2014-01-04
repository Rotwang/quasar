#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw[min max sum];

my @numbers;
my $sum;

chomp(@numbers = sort {$a <=> $b} (<>));
$sum = sum(@numbers);

print "min:    " . min(@numbers) . "\n";
print "max:    " . max(@numbers) . "\n";
print "mean:   " . $sum/@numbers . "\n";
print "median: " . $numbers[@numbers/2] . "\n";