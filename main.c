#include <stdio.h>
#include <stdlib.h>

#include "rns.h"

const char *usage =
"Usage:\n"
"  ./rns a\n"
"     Converts a number to RNS form\n\n"
"  ./rns a b\n"
"     Reads two decimals; performs operations in RNS\n"
"     and converts back to decimal\n\n"
"  ./rns a0 a1 a2 b0 b1 b2\n"
"     Reads two numbers in RNS form and performs\n"
"     operations\n";

const char *wrong_rns_base_msg =
"Wrong RNS base initialized\n"
"(This is a bug in the program code: %s:%d)\n"
"Aborting.";

void rns_init()
{
        // Make sure that we have a correct RNS base
        if (rns_base.r0 != 0x7fffffff
         || rns_base.r1 != 0x80000000
         || rns_base.r2 != 0x80000001) {
                fprintf(stderr, wrong_rns_base_msg, __FILE__, __LINE__);
                exit(1);
        }
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

        if (argc == 2) {
                fprintf(stderr, "Reading a decimal number %s\nTrying to convert to binary...\n", argv[1]);

                struct int128 value;

                if (read_int128(&value, argv[1])) {
                        fprintf(stderr, "Error while converting `%s` to binary\n", argv[1]);
                        return 1;
                }

                fprintf(stderr, "%s in binary form: %08x/%08x/%08x/%08x\n", argv[1], value.x3, value.x2, value.x1, value.x0);

                int_to_rns(&rns_a, &value);
                fprint_rns(stdout, &rns_a);
        } else if (argc == 3) {
                fprintf(stderr, "Reading two decimal numbers: %s and %s\n", argv[1], argv[2]);
        } else if (argc == 7) {
                fprintf(stderr, "Reading two numbers in RNS notation\n");

                sscanf(argv[1], "%ul", &rns_a.r0);
                sscanf(argv[2], "%ul", &rns_a.r1);
                sscanf(argv[3], "%ul", &rns_a.r2);

                sscanf(argv[4], "%ul", &rns_b.r0);
                sscanf(argv[5], "%ul", &rns_b.r1);
                sscanf(argv[6], "%ul", &rns_b.r2);

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
                fprintf(stderr, "Unknown mode of operation\n%s", usage);
                return 1;
        }

        return 0;
}
