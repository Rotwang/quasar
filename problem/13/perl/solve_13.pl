#!/usr/bin/env perl6
# http://projecteuler.net/problem=13

use v6;

my $file = open 'bignums';
my @bignums;
my @result;


@bignums.push([$_.split('')]) for $file.lines;
@result.push("0") for 1 .. @bignums[0].elems;

sub give_bigsum(@x, @y is copy) {
        my $carry = False;
        my @r;
        @y.unshift(0) for 1 .. @x.elems - @y.elems;
        for (0 .. @x.end).reverse {
                my $tmp = 0;
                $tmp = @x[$_] + @y[$_];
                        
                $tmp++ if $carry;
                if $tmp >= 10 {
                        $carry = True;
                        $tmp %= 10;
                } else {
                        $carry = False;
                }
                @r.unshift($tmp);
        }
        @r.unshift(1) if $carry;
        return @r;
}

for @bignums -> @bignum {
#        say [~] @result;
#        say [~] @bignum;
        @result = give_bigsum(@result, @bignum);
#        say [~] @result;
#        say ">>> ----- <<<";
}

say [~] @result[0..9];