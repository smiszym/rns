#!/usr/bin/env python3

import rns

max = 1
for i in rns.rns_base:
    max *= i
max -= 1

print("Base: " + str(rns.rns_base))
print("Maximum value: " + str(max))

rns.test_rns(4294967300, 4294967200)
rns.test_rns(4789342294967300, 4294967201557450)

print("If there are no errors, all tests passed.")
