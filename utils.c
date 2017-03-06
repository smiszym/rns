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
