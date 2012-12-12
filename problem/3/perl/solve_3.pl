#!/usr/bin/env perl6
# http://projecteuler.net/problem=3

use v6;

my $p = 2;
my $N = @*ARGS[0];
my @factors := gather while $N >= $p**2 {
        if $N % $p == 0 {
                take $p;
                $N /= $p;
        } else {
                $p++;
        }
}
@factors.push($N);

say [max] @factors;
