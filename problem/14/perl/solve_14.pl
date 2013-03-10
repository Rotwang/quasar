#!/usr/bin/env perl6
# http://projecteuler.net/problem=14

use v6;

sub get_collatz_length($n is copy) {
        my $passes = 0;
        loop (;;) {
                if $n == 1 { return $passes; }
                if $n % 2 == 0 {
                        $n /= 2;
                } else {
                        $n = 3 * $n + 1
                }
                $passes++;
        }
}

my %results;
loop (my $i = 1; $i < 1000000; $i++) { %results{get_collatz_length($i)}.push($i); }

say "number: " ~ %results{[max] %results.keys>>.Int}.perl;
say "length: " ~ [max] %results.keys>>.Int;
#n → n/2 (n is even)
#n → 3n + 1 (n is odd)