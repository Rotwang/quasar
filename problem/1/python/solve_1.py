#!/usr/bin/env python
# http://projecteuler.net/problem=1

import sys

upper_limit = int(sys.argv[1])
multipliers = [3, 5]
results = []

for x in multipliers:
        for y in range(1, upper_limit + 1):
                res = y * x
                if res < upper_limit:
                        results.append(res)

print sum(list(set(results)))