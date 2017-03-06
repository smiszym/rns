#include "rns.h"

#include <stdio.h>

void print_rns(struct rns *value)
{
        printf("[%d %d %d %d]=n", value->r0, value->r1, value->r2, value->r3);
}
