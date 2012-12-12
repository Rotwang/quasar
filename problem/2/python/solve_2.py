#!/usr/bin/env python
# http://projecteuler.net/problem=2

import sys

def even_fibonacci(n):
        a, b = 1, 2
        results = []
#        for i in range(0, n):
        while True:
                if a > n: break
                if a % 2 == 0:
                        results.append(a)
                a, b = b, a + b
        return results

print sum(even_fibonacci(int(sys.argv[1])))