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

int modulo_inverse(int a, int n);

void rns_add(struct rns *result, struct rns *a, struct rns *b);
void rns_sub(struct rns *result, struct rns *a, struct rns *b);
void rns_mul(struct rns *result, struct rns *a, struct rns *b);

/*
 * Returns 0 if the conversion was successful; 1 otherwise.
 */
int read_int128(struct int128 *result, const char *s);

// Loads a 32-bit integer, one of the RNS remainders,
// into a 128-bit variable
void load_r0_to_int128(struct int128 *dest, const struct rns *src);
void load_r1_to_int128(struct int128 *dest, const struct rns *src);
void load_r2_to_int128(struct int128 *dest, const struct rns *src);

// Adds a 32-bit integer, one of the RNS remainders,
// to a 128-bit variable
void add_r0_to_int128(struct int128 *dest, const struct rns *src);
void add_r1_to_int128(struct int128 *dest, const struct rns *src);
void add_r2_to_int128(struct int128 *dest, const struct rns *src);

void copy_int128(struct int128 *dest, const struct int128 *src);
void add_int128(struct int128 *dest, const struct int128 *src);
void sub_int128(struct int128 *dest, const struct int128 *src);

// Shifts the number in place. Only least significant byte of n is taken
// into account. This is to free the programmer from the need to
// zero out the rest of the argument register.
void shl_int128(struct int128 *result, int n);

void int_to_rns(struct rns *result, struct int128 *value);
void rns_to_int(struct int128 *dest, const struct rns *src);


// -- utils.c

void print_rns(struct rns *value);
void fprint_rns(FILE *stream, struct rns *value);

#endif
