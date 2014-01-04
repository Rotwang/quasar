#include <stdio.h>
#include <string.h>
#include "xxhash.h"

int main(int argc, char *argv[]) {
	if (argv[1] == NULL)
		return 1;
	printf("%X\n", XXH32(argv[1], strlen(argv[1]), 0));
	printf("%X\n", XXH32(NULL, 0, 0));
}
