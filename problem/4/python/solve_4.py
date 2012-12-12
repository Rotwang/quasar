#!/usr/bin/env python
# http://projecteuler.net/problem=4

import sys

# create palindromes
max_palindrome = 998001
min_palindrome =  10000
temp_palindrome = max_palindrome
palindrome_list = []

def is_palindrome(p):
        temp = list(str(p))
        temp_rev = temp[:]
        temp_rev.reverse()
        if temp == temp_rev:
                return True
        else:
                return False

while temp_palindrome >= min_palindrome:
        if is_palindrome(temp_palindrome):
                palindrome_list.append(temp_palindrome)
        temp_palindrome -= 1

for x in palindrome_list:
        for y in range(100,1000):
                if x % y == 0:
                        if x/y in range(100, 1000):
                                print "palindrome: " + str(x)
                                print "factors: " + str(y) + " " + str(x/y)
                                sys.exit(0)