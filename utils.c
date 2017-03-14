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

void rns_sub(struct rns *result, struct rns *a, struct rns *b)
{
        int64_t x;

        /* Perform subtraction on 64 bits */
        x = (int64_t) a->r0 - b->r0;
        /* The value shouldn't be negative */
        if (x < 0)
                x += rns_base.r0;
        /* Perform effective modulo */
        if (x >= rns_base.r0)
                x -= rns_base.r0;
        /* Store the result */
        result->r0 = x;

        /* Same algorithm for others */

        x = (int64_t) a->r1 - b->r1;
        if (x < 0)
                x += rns_base.r1;
        if (x >= rns_base.r1)
                x -= rns_base.r1;
        result->r1 = x;

        x = (int64_t) a->r2 - b->r2;
        if (x < 0)
                x += rns_base.r2;
        if (x >= rns_base.r2)
                x -= rns_base.r2;
        result->r2 = x;

        x = (int64_t) a->r3 - b->r3;
        if (x < 0)
                x += rns_base.r3;
        if (x >= rns_base.r3)
                x -= rns_base.r3;
        result->r3 = x;
}

void rns_mul(struct rns *result, struct rns *a, struct rns *b)
{
        result->r0 = (a->r0 * b->r0) % rns_base.r0;
        result->r1 = (a->r1 * b->r1) % rns_base.r1;
        result->r2 = (a->r2 * b->r2) % rns_base.r2;
        result->r3 = (a->r3 * b->r3) % rns_base.r3;
}
