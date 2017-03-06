#!/usr/bin/env python3

import random
from rns import *
import unittest

class TestPythonRNSConversion(unittest.TestCase):

    def test_1(self):
        a = 1
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_2(self):
        a = 152
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_3(self):
        a = 41278
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_4(self):
        a = 4294967196
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_5(self):
        a = 4294967197
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_6(self):
        a = 4294967198
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_7(self):
        a = 4294967230
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_8(self):
        a = 4294967231
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_9(self):
        a = 4294967232
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_10(self):
        a = 4294967278
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_11(self):
        a = 4294967279
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_12(self):
        a = 4294967280
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_13(self):
        a = 4294967290
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_14(self):
        a = 4294967291
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_15(self):
        a = 4294967292
        self.assertEqual(a, rns_to_int(int_to_rns(a)))

    def test_stress(self):
        random.seed()
        for i in range(100000):
            a = random.getrandbits(89)
            self.assertEqual(a, rns_to_int(int_to_rns(a)))


if __name__ == "__main__":
    max = 1
    for i in rns_base:
        max *= i
    max -= 1

    print("Base: " + str(rns_base))
    print("Maximum value: " + str(max))

    unittest.main()
