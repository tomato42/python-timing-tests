from __future__ import print_function
import sys
import time
import perf
import random

setup = """import random
from hmac import compare_digest
import operator
import numpy as np

def hash_cmp(val_a, val_b):
    if len(val_a) != len(val_b):
        return False
    if len(val_a) == len(val_b) == 0:
        return True

    ret = np.uint8(0)

    arr_a = np.array(bytearray(val_a), dtype=np.uint8)
    arr_b = np.array(bytearray(val_b), dtype=np.uint8)

    for a, b in zip(arr_a, arr_b):
        ret |= a ^ b

    return ret == np.uint8(0)

assert hash_cmp(b'abba', b'abba')
assert not hash_cmp(b'baab', b'abba')

rand = random.SystemRandom()

str_a = bytearray([rand.randrange(0, 256) for _ in range(32)])
str_b = bytearray(str_a)
for i in range({0}, 32):
    str_b[i] ^= rand.randrange(1, 256)

"""

fun = """hash_cmp(str_a, str_b)"""
fun2 = """compare_digest(str_a, str_b)"""

if __name__ == "__main__":
    reps = 64
    runner = perf.Runner(values=4, warmups=16, processes=reps//4)
    vals = list(range(10))
    #random.SystemRandom().shuffle(vals)
    for delta in vals:
        runner.timeit("hash_cmp delta={0:#04x}".format(delta), fun, setup=setup.format(delta))
