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
        load_r1_to_int128(dest, src);
        shl_int128(dest, 1);

        add_r0_to_int128(dest, src);
        add_r2_to_int128(dest, src);
        shl_int128(dest, 30);

        sub_r1_from_int128(dest, src);
        add_r2_to_int128(dest, src);
        shl_int128(dest, 1);

        add_r0_to_int128(dest, src);
        sub_r2_from_int128(dest, src);
        shl_int128(dest, 30);

        sub_r1_from_int128(dest, src);
        sub_r2_from_int128(dest, src);
        shl_int128(dest, 31);

        add_r1_to_int128(dest, src);

        int128_mod_M(dest);
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

void int128_mod_M(struct int128 *value)
{
        struct int128 tmp;
        struct int128 M;
        int i;

        M.x3 = 0x00000000;
        M.x2 = 0x1fffffff;
        M.x1 = 0xffffffff;
        M.x0 = 0x80000000;

        for (i = 35; i >= 0; --i) {
                tmp = M;
                shl_int128(&tmp, i);
                if (cmp_int128(value, &tmp) >= 0)
                        sub_int128(value, &tmp);
        }
}
