#include <stdio.h>
#include <stdlib.h>

#include "rns.h"

int main(int argc, char **argv)
{
        printf("sizeof(struct rns) == %lu\n", sizeof(struct rns));
        printf("sizeof(struct int128) == %lu\n", sizeof(struct int128));
        return 0;
}
