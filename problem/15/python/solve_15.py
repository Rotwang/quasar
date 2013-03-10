#!/usr/bin/env python

def find_indexes(x,arr):
        for i in range(0, len(arr)):
                if x in arr[i]:
                        
                        return [ i, arr[i].index(x) ]
               

grid_height = 3
grid_size = grid_height ** 2

grid = [ 9 for x in range(0, grid_height) ]
grid[0] = [ 1, 2, 3 ]
grid[1] = [ 4, 5, 6 ]
grid[2] = [ 7, 8, 9 ]

grid_conn = [ False for x in range(0, grid_size + 1) ]

x = 1
while x <= grid_size:
        if x - 1 >= 1:
                grid_conn[x].expand(grid[find_indexes(x - 1, grid)[0]][find_indexes(x - 1, grid)[1]]
        if x + 1 <=  grid_height:
                grid_conn[x].expand(grid[find_indexes(x + 1, grid)[0]][find_indexes(x + 1, grid)[1]])
        if x - grid_height >= 1:
                grid_conn[x].expand(grid[find_indexes(x - grid_height, grid)[0]][find_indexes(x + grid_height, grid)[1]])
        if x + grid_height <= 
                
#        grid_conn[x] = [
#                grid[find_indexes(x - 1, grid)[0]][find_indexes(x - 1, grid)[1]],
#                grid[find_indexes(x + 1, grid)[0]][find_indexes(x + 1, grid)[1]],
#                grid[find_indexes(x - grid_height, grid)[0]][find_indexes(x + grid_height, grid)[1]],
#                grid[find_indexes(x + grid_height, grid)[0]][find_indexes(x - grid_height, grid)[1]]
#        ]
        x += 1
        
        
#grid_conn[1] = [ grid_conn[0][1], grid_conn[1][0] ]
#grid_conn[2] = [ grid_conn[0][0], grid_conn[0][2], grid_conn[1][1] ]
#grid_conn[3] = [ grid_conn[0][1], grid_conn[1][2] ]
#y = 0
#while y < grid_height:
#        grid_con[y] += [y+1]
#        y += 1

print grid_conn
#x = 0
#while x < grid_size:
        