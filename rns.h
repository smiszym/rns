#ifndef RNS_H
#define RNS_H

#include <stdint.h>

struct rns {
        uint32_t m3;
        uint32_t m2;
        uint32_t m1;
        uint32_t m0;
} __attribute__((packed));

struct int128 {
        uint32_t x3;
        uint32_t x2;
        uint32_t x1;
        uint32_t x0;
} __attribute__((packed));

struct rns rns_base;
struct rns alt_base;

void rns_init();

int modulo_inverse(int a, int n);

void rns_add(struct rns result, struct rns a, struct rns b);
void rns_sub(struct rns result, struct rns a, struct rns b);
void rns_mul(struct rns result, struct rns a, struct rns b);

void int_to_rns(struct rns result, struct int128 value);
void rns_to_int(struct int128 result, struct rns value);

#endif
