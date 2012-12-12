#!/usr/bin/env perl6
# http://projecteuler.net/problem=1

use v6;

die "Exactly one argument needed (natural number)." unless @*ARGS;

my $upper_limit = @*ARGS[0];
my @multipliers = (3, 5);
my @results;

for @multipliers -> $m {
        loop (my $i = 1; $i * $m < $upper_limit; $i++) {
                @results.push($i * $m);
        }
}

say [+] @results.uniq;
