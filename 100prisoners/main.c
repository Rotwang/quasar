#include <stdbool.h>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#define DEV_RANDOM "/dev/urandom"

typedef unsigned int pris_t;

int main(int argc, char *argv[]) {
	
	srand(time(NULL));
	pris_t prisoners_n = atoi(argv[1]);
	prisoners_n %= RAND_MAX;
	bool bulb_lit = false; // false - off, true - on
	pris_t leader = 0;
	pris_t prisoner;
	pris_t counter = 1;
	pris_t *state = malloc(sizeof(bool) * prisoners_n);
	long long days = 0;
	
	int rand_fd = open(DEV_RANDOM, O_RDONLY);
	
	for (pris_t i = 0; i < prisoners_n; i++)
		state[i] = false;
	while (1) {
		++days;
		read(rand_fd, (void *)&prisoner, sizeof(prisoner));
		prisoner %= prisoners_n;
		//prisoner = rand() % prisoners_n;
		
		if (prisoner != leader) {
			if (state[prisoner] == false && bulb_lit == false){
				bulb_lit = true;
				state[prisoner] = true;
			}
		} else {
			if (bulb_lit == true) {
				bulb_lit = false;
				++counter;
			}
		}
		if (counter == prisoners_n) {
			printf("%llu\n", days);
			return EXIT_SUCCESS;
		}

	}
}
