from __future__ import print_function
import sys

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
split = 0

hash = hashlib.sha1
"""

fun = """hash_calc2(data, split, hash())"""

if __name__ == "__main__":
    import timeit
    import random
    import time
    rand = random.SystemRandom()
    reps = 4096
    times = [[] for _ in range(64)]
    try:
        # warmup
        timeit.repeat(fun, setup=setup.format(0), number=64, repeat=16)
        l = list(range(64))
        for x in range(reps):
            print("rep: {0}".format(x), file=sys.stderr, end="\r")
            rand.shuffle(l)
            for delta in l:
                times[delta].extend(timeit.repeat(fun, setup=setup.format(delta), timer=time.process_time, number=64, repeat=16)[1:])
        print(file=sys.stderr)
        print("len(times): {0}, len(times[0]): {1}".format(len(times), len(times[0])), file=sys.stderr)
    finally:
        # if we were killed by KeyboardInterrupt, still try to dump data
        print(", ".join("r{0}".format(i) for i in range(len(times[0]))))
        for t in times:
            print("{0}".format(", ".join(str(j) for j in t)))
