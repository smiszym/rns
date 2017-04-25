#include "rns.h"

#include <stdio.h>

void print_rns(struct rns *value)
{
        fprint_rns(stdout, value);
}

void fprint_rns(FILE *stream, struct rns *value)
{
        fprintf(stream, "%u %u %u\n", value->r0, value->r1, value->r2);
}

void print_int128(struct int128 *value)
{
        fprint_int128(stdout, value);
}

void fprint_int128(FILE *stream, struct int128 *value)
{
        fprintf(stream, "%08x/%08x/%08x/%08x\n",
                        value->x3, value->x2, value->x1, value->x0);
}

void rns_to_int(struct int128 *dest, const struct rns *src)
{
        struct int128 tmp;

        load_r0_to_int128(dest, src);
        shl_int128(dest, 31);
        add_r0_to_int128(dest, src);
        shl_int128(dest, 61);
        add_r1_to_int128(dest, src);
        load_r2_to_int128(&tmp, src);
        shl_int128(&tmp, 92);
        add_int128(dest, &tmp);
        load_r1_to_int128(&tmp, src);
        shl_int128(&tmp, 1);
        add_r2_to_int128(&tmp, src);
        shl_int128(&tmp, 61);
        sub_int128(dest, &tmp);
}

void int128_to_dec(char *buffer, const struct int128 *number)
{
        struct int128 tmp;
        int remainder;
        int i = 0;
        int j = 0;
        char c;

        copy_int128(&tmp, number);

        if (is_int128_zero(&tmp)) {
                buffer[0] = '0';
                buffer[1] = '\0';
                return;
        }

        while (!is_int128_zero(&tmp)) {
                remainder = divide_int128_by_10(&tmp);
                buffer[i++] = '0' + remainder; // append a digit
        }

        buffer[i] = '\0';

        // Reverse digit order
        --i;
        while (i > j) {
                c = buffer[i];
                buffer[i] = buffer[j];
                buffer[j] = c;
                --i;
                ++j;
        }
}
