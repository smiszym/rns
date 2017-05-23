#include "rns.h"

#include <stdio.h>

void print_rns(struct rns *value)
{
        fprint_rns(stdout, value);
}

void fprint_rns(FILE *stream, struct rns *value)
{
        fprintf(stream, "%u %u %u\n", value->r1, value->r2, value->r3);
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
