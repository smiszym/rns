#ifndef RNS_H
#define RNS_H

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

struct rns {
        uint32_t r1;
        uint32_t r2;
        uint32_t r3;
        uint32_t reserved; // not used; only 3 modules are used
} __attribute__((packed));

struct int128 {
        uint32_t x0; // least significant
        uint32_t x1;
        uint32_t x2;
        uint32_t x3; // most significant
} __attribute__((packed));

extern struct rns rns_base;
extern struct int128 M;

int modulo_inverse(int a, int n);

void rns_add(struct rns *result, struct rns *a, struct rns *b);
void rns_sub(struct rns *result, struct rns *a, struct rns *b);
void rns_mul(struct rns *result, struct rns *a, struct rns *b);

/*
 * Returns 0 if the conversion was successful; 1 otherwise.
 */
int read_int128(struct int128 *result, const char *s);

// This function converts a 128-bit number into a decimal
// representation and stores the result as ASCII null-terminated
// string.
//
// Assumes that the buffer is at least 40 bytes long, in order
// to be able to store largest 128-bit number decimal representation.
void int128_to_dec(char *buffer, const struct int128 *number);

// Loads a 32-bit integer, one of the RNS remainders,
// into a 128-bit variable
void load_r1_to_int128(struct int128 *dest, const struct rns *src);
void load_r2_to_int128(struct int128 *dest, const struct rns *src);
void load_r3_to_int128(struct int128 *dest, const struct rns *src);

// Adds a 32-bit integer, one of the RNS remainders,
// to a 128-bit variable
void add_r1_to_int128(struct int128 *dest, const struct rns *src);
void add_r2_to_int128(struct int128 *dest, const struct rns *src);
void add_r3_to_int128(struct int128 *dest, const struct rns *src);

// Subtracts a 32-bit integer, one of the RNS remainders,
// from a 128-bit variable
void sub_r1_from_int128(struct int128 *dest, const struct rns *src);
void sub_r2_from_int128(struct int128 *dest, const struct rns *src);
void sub_r3_from_int128(struct int128 *dest, const struct rns *src);

int cmp_int128(struct int128 *a, const struct int128 *b);

bool is_int128_zero(struct int128 *value);

void copy_int128(struct int128 *dest, const struct int128 *src);
void add_int128(struct int128 *dest, const struct int128 *src);
void sub_int128(struct int128 *dest, const struct int128 *src);

// The function stores the quotient in value
// and returns the remainder.
int divide_int128_by_10(struct int128 *value);

// The function calculates the remainder in division value by M
// and stores the result back in value.
void int128_mod_M(struct int128 *value);

// Shifts the number in place. Only least significant byte of n is taken
// into account. This is to free the programmer from the need to
// zero out the rest of the argument register.
void shl_int128(struct int128 *result, int n);

int int_to_rns(struct rns *result, struct int128 *value);
void rns_to_int(struct int128 *dest, const struct rns *src);


// -- utils.c

void print_rns(struct rns *value);
void fprint_rns(FILE *stream, struct rns *value);
void print_int128(struct int128 *value);
void fprint_int128(FILE *stream, struct int128 *value);

#endif
