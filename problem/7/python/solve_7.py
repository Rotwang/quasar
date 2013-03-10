#!/usr/bin/env python
# http://projecteuler.net/problem=7

candidates = range(2,150000)

primes = []

while candidates:
        primes.append(candidates.pop(0))
        print primes[-1]
        candidates = filter(lambda x: x % primes[-1], candidates)

print primes[-1]
print primes[10000]