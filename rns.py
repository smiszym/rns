#!/usr/bin/env python3

def modulo_inverse(a, n):
    u = 1
    w = a
    x = 0
    z = n
    while w > 0:
        if w < z:
            q = u; u = x; x = q
            q = w; w = z; z = q
        q = w // z
        u -= q * x
        w -= q * z
    if z == 1:
        if x < 0:
            x += n
        return x

rns_base = [0x7fffffff, 0x80000000, 0x80000001]

M = 1
for m in rns_base:
    M *= m

alt_base = [M // rns_base[i] for i in range(len(rns_base))]
residual_ones = [alt_base[i] * modulo_inverse(alt_base[i], rns_base[i]) for i in range(len(rns_base))]

def rns_add(a, b):
    return [((a[i]+b[i]) % rns_base[i]) for i in range(len(rns_base))]

def rns_sub(a, b):
    return [((a[i]-b[i]) % rns_base[i]) for i in range(len(rns_base))]

def rns_mul(a, b):
    return [((a[i]*b[i]) % rns_base[i]) for i in range(len(rns_base))]

def int_to_rns(n):
    return [(n % q) for q in rns_base]

def rns_to_int(n):
    return sum([residual_ones[i] * n[i] for i in range(len(rns_base))]) % M

def test_rns(a, b):
    a_rns = int_to_rns(a)
    b_rns = int_to_rns(b)
    assert a == rns_to_int(a_rns)
    assert b == rns_to_int(b_rns)
    assert a+b == rns_to_int(rns_add(a_rns, b_rns))
    assert a*b == rns_to_int(rns_mul(a_rns, b_rns))
    if a >= b:
        assert a-b == rns_to_int(rns_sub(a_rns, b_rns))
    else:
        assert b-a == rns_to_int(rns_sub(b_rns, a_rns))
