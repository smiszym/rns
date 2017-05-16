#include "unit_test.h"

#include <stdio.h>
#include <string.h>

#include "rns.h"

static const char *usage =
"Copyright (C) Michał Szymański, 2017\n"
"Projekt w ramach przedmiotu Architektura Komputerów 2\n"
"Prowadzący: mgr inż. Aleksandra Postawka\n"
"Politechnika Wrocławska\n"
"\n"
"Invocation %s test [...] is meant to output functions\n"
"results to stdout for examination if the functions\n"
"operate correctly.\n"
"\n"
"Usage:\n"
"  ./rns test dec_to_bin <n>\n"
"     Input:\n"
"       n - a decimal number in range <0, 2^89>\n"
"     Output:\n"
"       the same number, after conversion to int128 and back\n";

int unit_testing(int argc, char **argv)
{
        struct int128 value_a;
        char string_buffer[40];

        if (argc == 4 && !strcmp(argv[2], "dec_to_bin")) {
                fprintf(stderr, "Read a decimal number %s.\n", argv[3]);

                if (read_int128(&value_a, argv[3])) {
                        fprintf(stderr, "Error while converting `%s` to binary\n", argv[1]);
                        return 1;
                }

                fprintf(stderr, "In a binary form: ");
                fprint_int128(stderr, &value_a);

                int128_to_dec(string_buffer, &value_a);
                fprintf(stderr, "The value converted back: %s\n", string_buffer);

                puts(string_buffer);
        } else {
                fprintf(stderr, usage, argv[0]);
        }

        return 0;
}
