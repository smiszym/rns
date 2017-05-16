#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "rns.h"
#include "unit_test.h"

static const char *usage =
"Copyright (C) Michał Szymański, 2017\n"
"Projekt w ramach przedmiotu Architektura Komputerów 2\n"
"Prowadzący: mgr inż. Aleksandra Postawka\n"
"Politechnika Wrocławska\n"
"\n"
"RNS base: [%u %u %u] (decimal)\n"
"\n"
"Usage:\n"
"  ./rns a\n"
"     Converts a decimal number to RNS form.\n"
"     Input:\n"
"       a - decimal number (max 89-bit)\n"
"     Output:\n"
"       the number in RNS form\n"
"\n"
"  ./rns a0 a1 a2 b0 b1 b2\n"
"     Reads two numbers in RNS form and performs operations.\n"
"     Input:\n"
"       [a0 a1 a2], [b0 b1 b2] - numbers in RNS notation\n"
"     Output: \n"
"       (RNS form) sum\n"
"       (RNS form) difference\n"
"       (RNS form) product\n"
"\n"
"  ./rns a b\n"
"     Reads two decimals; performs operations in RNS\n"
"     and converts back to decimal.\n"
"     Input:\n"
"       a, b - decimal numbers (max 89-bit)\n"
"     Output: \n"
"       (decimal)  sum\n"
"       (decimal)  difference\n"
"       (decimal)  product\n"
"\n"
"  ./rns test\n"
"     Prints information on how to invoke the program\n"
"     for unit testing.\n";

static const char *wrong_rns_base_msg =
"Wrong RNS base initialized\n"
"(This is a bug in the program code: %s:%d)\n"
"Aborting.";

static void rns_init()
{
        // Make sure that we have a correct RNS base
        if (rns_base.r0 != 0x7fffffff
         || rns_base.r1 != 0x80000000
         || rns_base.r2 != 0x80000001) {
                fprintf(stderr, wrong_rns_base_msg, __FILE__, __LINE__);
                exit(1);
        }
}

static struct int128 value_a;
static struct int128 value_b;
static struct rns rns_a;
static struct rns rns_b;
static struct rns rns_sum;
static struct rns rns_diff;
static struct rns rns_prod;

static char string_buffer[40];

static void perform_actual_computations()
{
        rns_add(&rns_sum, &rns_a, &rns_b);
        rns_sub(&rns_diff, &rns_a, &rns_b);
        rns_mul(&rns_prod, &rns_a, &rns_b);
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

        if (argc >= 2 && !strcmp(argv[1], "test")) {
                return unit_testing(argc, argv);
        }

        if (argc == 2) {
                fprintf(stderr, "Read a decimal number %s.\n", argv[1]);

                if (read_int128(&value_a, argv[1])) {
                        fprintf(stderr, "Error while converting `%s` to binary\n", argv[1]);
                        return 1;
                }

                fprintf(stderr, "In a binary form: ");
                fprint_int128(stderr, &value_a);

                int_to_rns(&rns_a, &value_a);
                fprintf(stderr, "The RNS representation is: ");
                fprint_rns(stderr, &rns_a);
                fprint_rns(stdout, &rns_a);

                rns_to_int(&value_b, &rns_a);
                int128_to_dec(string_buffer, &value_b);
                fprintf(stderr, "The value converted back: %s\n", string_buffer);

                // Sanity check
                if (strcmp(string_buffer, argv[1])) {
                        fprintf(stderr, "ERROR: Decimal representation is different from original\n");
                        fprintf(stderr, "       Binary representation after reverse conversion: ");
                        fprint_int128(stderr, &value_b);
                }
        } else if (argc == 3) {
                fprintf(stderr, "Reading two decimal numbers: %s and %s\n", argv[1], argv[2]);

                if (read_int128(&value_a, argv[1])) {
                        fprintf(stderr, "Error while converting `%s` to binary\n", argv[1]);
                        return 1;
                }

                if (read_int128(&value_b, argv[2])) {
                        fprintf(stderr, "Error while converting `%s` to binary\n", argv[2]);
                        return 1;
                }

                fprintf(stderr, "In a binary form: ");
                fprint_int128(stderr, &value_a);
                fprintf(stderr, "                  ");
                fprint_int128(stderr, &value_b);

                int_to_rns(&rns_a, &value_a);
                int_to_rns(&rns_b, &value_b);
                fprintf(stderr, "The RNS representations are: ");
                fprint_rns(stderr, &rns_a);
                fprintf(stderr, "                             ");
                fprint_rns(stderr, &rns_b);

                perform_actual_computations();

                rns_to_int(&value_a, &rns_sum);
                int128_to_dec(string_buffer, &value_a);
                fprintf(stderr, "       Sum: %s\n", string_buffer);
                puts(string_buffer);

                rns_to_int(&value_a, &rns_diff);
                int128_to_dec(string_buffer, &value_a);
                fprintf(stderr, "Difference: %s\n", string_buffer);
                puts(string_buffer);

                rns_to_int(&value_a, &rns_prod);
                int128_to_dec(string_buffer, &value_a);
                fprintf(stderr, "   Product: %s\n", string_buffer);
                puts(string_buffer);
        } else if (argc == 7) {
                fprintf(stderr, "Reading two numbers in RNS notation\n");

                sscanf(argv[1], "%ul", &rns_a.r0);
                sscanf(argv[2], "%ul", &rns_a.r1);
                sscanf(argv[3], "%ul", &rns_a.r2);

                sscanf(argv[4], "%ul", &rns_b.r0);
                sscanf(argv[5], "%ul", &rns_b.r1);
                sscanf(argv[6], "%ul", &rns_b.r2);

                fprintf(stderr, "The two numbers are:\n");
                fprint_rns(stderr, &rns_a);
                fprint_rns(stderr, &rns_b);

                perform_actual_computations();

                fprintf(stderr, "Sum: ");
                fprint_rns(stderr, &rns_sum);

                fprintf(stderr, "Difference: ");
                fprint_rns(stderr, &rns_diff);

                fprintf(stderr, "Product: ");
                fprint_rns(stderr, &rns_prod);

                fprint_rns(stdout, &rns_sum);
                fprint_rns(stdout, &rns_diff);
                fprint_rns(stdout, &rns_prod);
        } else {
                fprintf(stderr, usage, rns_base.r0, rns_base.r1, rns_base.r2);
                return 1;
        }

        return 0;
}
