#!/usr/bin/env python3

from c_invocation import invoke_native
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


class TestPythonRNSAdd(unittest.TestCase):

    def test_stress(self):
        random.seed()
        for i in range(100000):
            a = random.getrandbits(88)
            b = random.getrandbits(88)
            a_rns = int_to_rns(a)
            b_rns = int_to_rns(b)
            self.assertEqual(a+b, rns_to_int(rns_add(a_rns, b_rns)))


class TestPythonRNSSub(unittest.TestCase):

    def test_stress(self):
        random.seed()
        for i in range(100000):
            a = random.getrandbits(89)
            b = random.getrandbits(89)
            if a < b:
                tmp = a
                a = b
                b = tmp
            a_rns = int_to_rns(a)
            b_rns = int_to_rns(b)
            self.assertEqual(a-b, rns_to_int(rns_sub(a_rns, b_rns)))


class TestPythonRNSMul(unittest.TestCase):

    def test_stress(self):
        random.seed()
        for i in range(100000):
            a = random.getrandbits(44)
            b = random.getrandbits(44)
            a_rns = int_to_rns(a)
            b_rns = int_to_rns(b)
            self.assertEqual(a*b, rns_to_int(rns_mul(a_rns, b_rns)))


class TestNativeProgram(unittest.TestCase):

    def test_stress(self):
        random.seed()
        for i in range(1000):
            a = random.getrandbits(44)
            b = random.getrandbits(44)
            #print("Testing C program for " + str(a) + " and " + str(b))
            a_rns = int_to_rns(a)
            b_rns = int_to_rns(b)
            sum, diff, prod = invoke_native(a_rns, b_rns)
            self.assertListEqual(rns_add(a_rns, b_rns), sum)
            self.assertListEqual(rns_sub(a_rns, b_rns), diff)
            #self.assertListEqual(rns_mul(a_rns, b_rns), prod)


if __name__ == "__main__":
    max = 1
    for i in rns_base:
        max *= i
    max -= 1

    print("Base: " + str(rns_base))
    print("Maximum value: " + str(max))

    unittest.main()
