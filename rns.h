#ifndef RNS_H
#define RNS_H

#include <stdint.h>
#include <stdio.h>

struct rns {
        uint32_t r0;
        uint32_t r1;
        uint32_t r2;
        uint32_t reserved; // not used; only 3 modules are used
} __attribute__((packed));

struct int128 {
        uint32_t x0; // least significant
        uint32_t x1;
        uint32_t x2;
        uint32_t x3; // most significant
} __attribute__((packed));

extern struct rns rns_base;

// Init RNS base to the project default
void rns_init();

int modulo_inverse(int a, int n);

void rns_add(struct rns *result, struct rns *a, struct rns *b);
void rns_sub(struct rns *result, struct rns *a, struct rns *b);
void rns_mul(struct rns *result, struct rns *a, struct rns *b);

/*
 * Returns 0 if the conversion was successful; 1 otherwise.
 */
int read_int128(struct int128 *result, const char *s);

void int_to_rns(struct rns result, struct int128 value);
void rns_to_int(struct int128 result, struct rns value);


// -- utils.c

void print_rns(struct rns *value);
void fprint_rns(FILE *stream, struct rns *value);

#endif
