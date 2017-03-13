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
        rns_init();

        if (sizeof(struct rns) != 16) {
                fprintf(stderr, "Error: sizeof(struct rns) != 16 B\nExiting.");
                return 1;
        }
        if (sizeof(struct int128) != 16) {
                fprintf(stderr, "Error: sizeof(struct int128) != 16 B\nExiting.");
                return 1;
        }

        struct rns rns_a;
        struct rns rns_b;
        struct rns rns_sum;
        struct rns rns_diff;
        struct rns rns_prod;

        if (argc == 3) {
                fprintf(stderr, "Reading two decimal numbers: %s and %s\n", argv[1], argv[2]);
        } else if (argc == 9) {
                fprintf(stderr, "Reading two numbers in RNS notation\n");

                sscanf(argv[1], "%ul", &rns_a.r0);
                sscanf(argv[2], "%ul", &rns_a.r1);
                sscanf(argv[3], "%ul", &rns_a.r2);
                sscanf(argv[4], "%ul", &rns_a.r3);

                sscanf(argv[5], "%ul", &rns_b.r0);
                sscanf(argv[6], "%ul", &rns_b.r1);
                sscanf(argv[7], "%ul", &rns_b.r2);
                sscanf(argv[8], "%ul", &rns_b.r3);

                /* Actual operations */
                rns_add(&rns_sum, &rns_a, &rns_b);
                rns_sub(&rns_diff, &rns_a, &rns_b);
                rns_mul(&rns_prod, &rns_a, &rns_b);

                /* Human-readable: stderr */
                fprintf(stderr, "The two numbers are:\n");
                fprint_rns(stderr, &rns_a);
                fprint_rns(stderr, &rns_b);

                fprintf(stderr, "Sum: ");
                fprint_rns(stderr, &rns_sum);

                fprintf(stderr, "Difference: ");
                fprint_rns(stderr, &rns_diff);

                fprintf(stderr, "Product: ");
                fprint_rns(stderr, &rns_prod);

                /* Computer-readable: stdout */
                fprint_rns(stdout, &rns_sum);
                fprint_rns(stdout, &rns_diff);
                fprint_rns(stdout, &rns_prod);

        } else {
                fprintf(stderr, "Unknown mode of operation - "
                                "wrong number of arguments "
                                "(should be 2 or 8)\n");
                return 1;
        }

        return 0;
}
