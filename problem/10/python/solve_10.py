#!/usr/bin/env python
# http://projecteuler.net/problem=10

candidates = range(2,2000000)

primes = []

while candidates:
        primes.append(candidates.pop(0))
        print primes[-1]
        candidates = filter(lambda x: x % primes[-1], candidates)

print primes[-1]
print sum(primes)