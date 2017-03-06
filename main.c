#include <stdio.h>
#include <stdlib.h>

#include "rns.h"

void rns_init()
{
        rns_base.r0 = 4294967197;
        rns_base.r1 = 4294967231;
        rns_base.r2 = 4294967279;
        rns_base.r3 = 4294967291;
}

int main(int argc, char **argv)
{
        printf("sizeof(struct rns) == %lu\n", sizeof(struct rns));
        printf("sizeof(struct int128) == %lu\n", sizeof(struct int128));
        return 0;
}
