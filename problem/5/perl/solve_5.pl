#!/usr/bin/env perl6
# http://projecteuler.net/problem=5

use v6;

my @numbers_to_divide_by = (11..19);

loop (my $x = 33522128640; $x > 0 ; $x -= 20) {
        my $success = True;
        for @numbers_to_divide_by -> $y {
                unless $x % $y == 0 {
                        $success = False;
                        last;
                }
        }
        if ($success) {
                say $x;
        }
}
