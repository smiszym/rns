#!/usr/bin/env python3

import rns

rns.test_rns(4294967300, 4294967200)
rns.test_rns(4789342294967300, 4294967201557450)

print("If there are no errors, all tests passed.")
