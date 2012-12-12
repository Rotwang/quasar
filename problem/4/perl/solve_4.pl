#!/usr/bin/env perl6
# http://projecteuler.net/problem=4

use v6;

my $max_palindrome = 997;
my $min_palindrome =  100;

loop (my $temp_palindrome = $max_palindrome; $temp_palindrome >= $min_palindrome; $temp_palindrome--) {
        my $x = $temp_palindrome ~ $temp_palindrome.split('').reverse().join();
        for 100 .. 999 -> $y {
                my $z = $x/$y;
                if ($z.Int == $z) and ($z ~~ 100 .. 999)  {
                        say "Palindrome: " ~ $x;
                        say "Factors:    " ~ $y ~ " " ~ $z;
                        exit 0;
                }
        }
}
