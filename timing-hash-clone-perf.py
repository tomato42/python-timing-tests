from __future__ import print_function
import sys
import time
import perf
import random

setup = """import hashlib
import numpy as np

def hash_calc(data, split, hash):

    hash.update(data[:split])
    hash.copy().digest()
    hash.update(data[split:])

    return hash.digest()

def hash_calc2(data, split, hash):

    for i, b in enumerate(data):
        hash.copy().digest()
        hash.update(bytearray([b]))

    return hash.digest()

data = bytearray([0xff] * 64)
split = {0}

hash = hashlib.sha1
"""

fun = """hash_calc(data, split, hash())"""

if __name__ == "__main__":
    reps = 25*16#16 * 1024
    runner = perf.Runner(values=16, warmups=16, processes=reps//16)
    vals = list(range(8))
    for delta in vals:
        runner.timeit("hash_cmp delta, {0:#04x}".format(delta), fun, setup=setup.format(delta))
