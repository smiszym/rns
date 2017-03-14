#include "rns.h"

#include <stdio.h>

void print_rns(struct rns *value)
{
        fprint_rns(stdout, value);
}

void fprint_rns(FILE *stream, struct rns *value)
{
        fprintf(stream, "%u %u %u %u\n", value->r0, value->r1, value->r2, value->r3);
}


// -- To be later implemented in Assembler

void rns_mul(struct rns *result, struct rns *a, struct rns *b)
{
        uint64_t x;

        x = (uint64_t) a->r0 * b->r0;
        x = x % rns_base.r0;
        result->r0 = x;

        x = (uint64_t) a->r1 * b->r1;
        x = x % rns_base.r1;
        result->r1 = x;

        x = (uint64_t) a->r2 * b->r2;
        x = x % rns_base.r2;
        result->r2 = x;

        x = (uint64_t) a->r3 * b->r3;
        x = x % rns_base.r3;
        result->r3 = x;
}
