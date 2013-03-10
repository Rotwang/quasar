#!/usr/bin/env perl6
# http://projecteuler.net/problem=9

use v6;

for (1 .. 499).reverse() -> $b {
        say "B: $b";
        for (0 .. $b - 1).reverse() -> $a {
                my $c = 1000 - $b - $a;
                if ($c ** 2 == $a ** 2 + $b ** 2) {
                    say "a: $a b: $b c: $c";
                    say "sum: {$a * $b * $c}";
                    exit 0
                }
        }
}
