#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>

#define WAV_FILE_IN "fristajla.flac"
#define WAV_FILE_OUT "fristajla_mod.flac"
#define TO_SKIP 16384

int main(void) {
        uint8_t mask[] = {
                0x00,
                0x01,
                0x02,
                0x04,
                0x08,
                0x10,
                0x20,
                0x40,
                0x80
        };
        FILE *wav_in, *wav_out;
        wav_in = fopen(WAV_FILE_IN, "r");
        wav_out = fopen(WAV_FILE_OUT, "w");
        uint8_t data, mod_data;
        int skip = 0;
        srand(time(NULL));
        while (fread(&data, 1, 1, wav_in)) {
                mod_data = (skip < TO_SKIP) ? data : data ^ mask[rand()%9];
                fwrite(&mod_data, 1, 1, wav_out);
                skip++;
        }
        fclose(wav_in);
        fclose(wav_out);
        return EXIT_SUCCESS;
}

