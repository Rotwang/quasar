#!/usr/bin/env python
# something is fucked up here
# see solution here: http://mathworld.wolfram.com/LatticePath.html

from math import ceil
import sys

grid_width = int(sys.argv[1])
grid_size = grid_width ** 2

grid_conn = [ [] for x in range(0, grid_size + 1) ]

x=1
while x <= grid_size:
        current_line_no = int(ceil(float(x)/grid_width))
        first_curr_line = ((current_line_no - 1) * grid_width) + 1
        last_curr_line  = (current_line_no * grid_width)
        current_line = range(first_curr_line, last_curr_line + 1)
        
        current_column_no = x - first_curr_line + 1
        current_column = range(current_column_no, grid_size - (grid_width - current_column_no) + 1, grid_width)

        if (x - 1) in current_line:
                grid_conn[x].append(x - 1)
        if (x + 1) in current_line:
                grid_conn[x].append(x + 1)
        if (x - grid_width) in current_column:
                grid_conn[x].append(x - grid_width)
        if (x + grid_width) in current_column:
                grid_conn[x].append(x + grid_width)
        x += 1

print grid_conn[1:]

#print grid_conn
#combination_len = (grid_width * 2) - 1
#combination_infix_len = combination_len - 2
#combination_prefix = 1
#combination_suffix = grid_size
#combination_infix = range(combination_prefix + 1, combination_suffix)


#del grid_conn[1][1]
#
#foo = 1
#while True:
#        if foo == 9:
#            print "found"
#        for y in grid_conn[foo]:
#                if y > foo:
#                        foo = y
#                        break

hurr = len(grid_conn) -1

def foo(st):
        if st == hurr:
                print "Found"
                return
        for x in grid_conn[st]:
                if x > st:
                        foo(x)


foo(1)
