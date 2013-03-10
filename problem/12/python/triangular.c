#include <stdio.h>
#include <stdlib.h>

int main(void) {
	unsigned long long bignum = 0;
        for (unsigned long long i = 1; ; i++) {
		unsigned int divisors = 2;
		int foo = 0;
		bignum += i;
		if (bignum % 2 == 0) {
			for (unsigned long long y = 2; y < bignum; y++) {
				if (bignum % y == 0)
					divisors++;
				if (divisors == 3 && y == 2) {
					foo++;
				} else if (divisors == 4 && y == 3) {
					foo++;
				} else if (divisors == 5 && y == 4) {
					foo++;
				} else if (y > 4 && foo < 3) {
					break;
				}
			}
		}
		if (divisors > 500) {
			printf("number: %lu, divisors: %u\n", bignum, divisors);
			exit(0);
		}
		printf("%lu divisors: %u\n", bignum,  divisors);

	}
	return 0;
}

