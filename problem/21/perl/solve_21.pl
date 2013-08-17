#!/usr/bin/env perl

#Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
#If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called #amicable numbers.

#For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = #284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

#Evaluate the sum of all the amicable numbers under 10000.

use strict;
use warnings;
use feature "say";
use List::Util "sum";
use Data::Dumper;

my $limit = 10000;
my %numberz;
my @friends;
for (my $x = 2; $x <= $limit; $x++) {
        my @divisors = ( 1 );
        for (my $y = $x - 1; $y > 1; $y--) {
                push @divisors, $y if ($x % $y == 0);
        }
        #print "$x: @divisors\n";
        $numberz{$x} = sum(@divisors);
}

for (my $x = 2; $x <= $limit; $x++) {
        my $q = $numberz{$x};
        next if ($q == 1 or $q > $limit);
        my $w = $numberz{$q};
        #print "$x: $numberz{$x}, $w\n";
        #if ($numberz{220} == 284 and $numberz{284} == 220) {
        if ($w == $x and $x != $q) {
                next if grep { ($_ eq $x) or ($_ eq $q) } @friends;
                push @friends, ($x, $q);
        }
}

say sum(@friends);
