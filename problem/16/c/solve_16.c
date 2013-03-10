#include <stdlib.h>
#include <stdio.h>
#include <gmp.h>

int main(int argc, char *argv[]) {
        mpz_t result;
        mpz_init(result);
        
        mpz_ui_pow_ui(result, 2UL, 1000UL);
        
        mpz_out_str(stdout, 10, result);
        
        mpz_clear(result);
        return EXIT_SUCCESS;
}
