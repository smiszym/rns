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
