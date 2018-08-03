from __future__ import print_function
import sys

setup = """import random
from hmac import compare_digest
import numpy as np
import operator
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

assert hash_cmp(bytearray(b'abba'), bytearray(b'abba'))
assert not hash_cmp(bytearray(b'baab'), bytearray(b'abba'))

rand = random.SystemRandom()

str_a = bytearray([rand.randrange(0, 256) for _ in range(32)])
str_b = bytearray(str_a)
for i in range({0}, 32):
    str_b[i] ^= rand.randrange(1, 256)

"""

fun = """hash_cmp(str_a, str_b)"""
fun2 = """compare_digest(str_a, str_b)"""

if __name__ == "__main__":
    import timeit
    import random
    rand = random.SystemRandom()
    reps = 256
    times = [[] for _ in range(32)]
    try:
        l = list(range(32))
        for x in range(reps):
            print("rep: {0}".format(x), file=sys.stderr, end="\r")
            rand.shuffle(l)
            for delta in l:
                times[delta].extend(timeit.repeat(fun, setup=setup.format(delta), number=200, repeat=4))
        print(file=sys.stderr)
        print("len(times): {0}, len(times[0]): {1}".format(len(times), len(times[0])), file=sys.stderr)
    finally:
        # if we were killed by KeyboardInterrupt, still try to dump data
        print(", ".join("r{0}".format(i) for i in range(len(times[0]))))
        for i in range(256):
            print("{0}".format(", ".join(str(j) for j in times[i])))
