#!/usr/bin/env perl6
# http://projecteuler.net/problem=7

use v6;

my @candidates = (2 .. 149999);

my @primes;

#say Array.^methods>>.name.perl;
# (@candidates Z=> @candidates.keys).hash.<$c>
loop (;@candidates.elems > 0;) {
        @primes.push(@candidates.shift());
        say @primes[* - 1];
#        for 0 .. @candidates.end() -> $c {
#                if @candidates[$c] % @primes[* - 1] == 0 {
#                        @candidates.delete($c);
#                }
#        }
        @candidates = grep { $_ % @primes[* - 1] != 0 }, @candidates;
}

say "elements: " ~ @primes.elems;
say "last prime: " ~ @primes[* - 1];
say "10001: " ~ @primes[10000];
