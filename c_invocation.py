#!/usr/bin/env python3

from rns import *
from subprocess import Popen, PIPE


def str_to_rns(s):
    return [int(a) for a in s.split(' ')]


def invoke_native(num_a, num_b):
    """
    num_a and num_b should be either Python RNS numbers
    or Python integers.
    """
    if type(num_a) is list and type(num_b) is list:
        p = Popen(['./rns', \
            str(num_a[0]), str(num_a[1]), str(num_a[2]), str(num_a[3]),  \
            str(num_b[0]), str(num_b[1]), str(num_b[2]), str(num_b[3])], \
            stdout=PIPE, stderr=PIPE)
        lines = p.communicate()[0].decode('UTF-8').split('\n')
        return [str_to_rns(s) for s in lines[:-1]]
    if type(num_a) is int and type(num_b) is int:
        p = Popen(['./rns', \
            str(num_a), str(num_b)], \
            stdout=PIPE, stderr=PIPE)
        lines = p.communicate()[0].decode('UTF-8').split('\n')
        return [int(s) for s in lines[:-1]]


if __name__ == "__main__":
    print(invoke_native(int_to_rns(2), int_to_rns(4)))
    print(invoke_native([1, 2, 3, 4], [9, 8, 7, 6]))
    print(invoke_native(56, 23))
