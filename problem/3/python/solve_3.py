#!/usr/bin/env python
# http://projecteuler.net/problem=3

import sys

N = int(sys.argv[1])
p = 2
factors = []

while N >= p**2:
        if N % p == 0:
                factors.append(p)
                N /= p
        else:
                p = p + 1
factors.append(N)

print max(factors)
print factors
