#!/usr/bin/env perl6
# http://projecteuler.net/problem=2

use v6;

my ($a, $b) = (1, 2);
my $temp;
my @results := gather loop (;;) {
        if $a > @*ARGS[0] { last; }
        if $a % 2 == 0 { take $a; }
        $temp = $b;
        $b = $a + $b;
        $a = $temp;
}

say [+] @results;
