#!/usr/bin/env python
# http://projecteuler.net/problem=5

numbers_to_divide_by = range(11,20)

x = 33522128640

while x > 0:
        success = True
        for y in numbers_to_divide_by:
                if not x % y == 0:
                        success = False
                        break
        if success:
                print x
        x -= 20
