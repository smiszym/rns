#include "rns.h"

#include <stdio.h>

void print_rns(struct rns *value)
{
        fprint_rns(stdout, value);
}

void fprint_rns(FILE *stream, struct rns *value)
{
        fprintf(stream, "[%d %d %d %d]\n", value->r0, value->r1, value->r2, value->r3);
}


// -- To be later implemented in Assembler

void rns_sub(struct rns *result, struct rns *a, struct rns *b)
{
        result->r0 = (a->r0 - b->r0) % rns_base.r0;
        result->r1 = (a->r1 - b->r1) % rns_base.r1;
        result->r2 = (a->r2 - b->r2) % rns_base.r2;
        result->r3 = (a->r3 - b->r3) % rns_base.r3;
}

void rns_mul(struct rns *result, struct rns *a, struct rns *b)
{
        result->r0 = (a->r0 * b->r0) % rns_base.r0;
        result->r1 = (a->r1 * b->r1) % rns_base.r1;
        result->r2 = (a->r2 * b->r2) % rns_base.r2;
        result->r3 = (a->r3 * b->r3) % rns_base.r3;
}
