#!/usr/bin/env python
# http://projecteuler.net/problem=12

import sys

mysum = 0
y = 1
#for x in range(1, 200):
#        mysum += x
#        divisors = 0
#        div_ar = []
divisors = 0
#for y in range(1, 7966312201):
while y <= 4819214400:
        if 4819214400 % y == 0:
                divisors += 1
        y += 1
print "divisors: " + str(divisors)
print "number:   " + str(mysum)
#        print str(mysum) + " " + str(divisors)
#        if divisors >= 500:
#                print "divisors: " + str(divisors)
#                print "number:   " + str(mysum)
#                sys.exit(0)
# 17907120 480 divisors
#		76576500 http://oeis.org/A076711
