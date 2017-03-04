#!/usr/bin/env python3

rns_base = [4294967197, 4294967231, 4294967279, 4294967291]

M = 1
for m in rns_base:
    M *= m

alt_base = [M / rns_base[i] for i in range(len(rns_base))]

def rns_add(a, b):
    return [((a[i]+b[i]) % rns_base[i]) for i in range(len(rns_base))]

def rns_sub(a, b):
    return [((a[i]-b[i]) % rns_base[i]) for i in range(len(rns_base))]

def rns_mul(a, b):
    return [((a[i]*b[i]) % rns_base[i]) for i in range(len(rns_base))]
        
def int_to_rns(n):
    return [(n % q) for q in rns_base]

def rns_to_int(n):
    return 0

def test_rns(a, b):
    assert a+b == rns_to_int(rns_add(int_to_rns(a), int_to_rns(b)))
    assert a-b == rns_to_int(rns_sub(int_to_rns(a), int_to_rns(b)))
    assert a*b == rns_to_int(rns_mul(int_to_rns(a), int_to_rns(b)))
