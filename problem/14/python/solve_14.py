#!/usr/bin/env python


def get_collatz_length(n):
        passes = 0
        x = n
        while True:
                if x == 1:
                        return passes
                if x % 2 == 0:
                        x /= 2
                else:
                        x = 3 * x + 1
                passes += 1

results_a = []
results_b = []
for f in range(1, 1000000):
        results_a.append(f)
        results_b.append(get_collatz_length(f))

print max(results_b)
print results_a[results_b.index(max(results_b))]