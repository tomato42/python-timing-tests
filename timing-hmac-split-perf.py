import perf

setup = """
import hmac
from hashlib import sha1

def fun(digest, data, split):
    digest.update(data[:split])
    ret = digest.copy().digest()
    digest.update(data[split:])
    return ret, digest.digest()

str_a = memoryview(b'X'*256)
key = b'a' * 32

val_b = {0}

mac = hmac.new(key, digestmod=sha1)
"""

fun = """fun(mac.copy(), str_a, val_b)"""

if __name__ == "__main__":
    total_runs = 128
    runs_per_process = 4
    runner = perf.Runner(values=runs_per_process,
                         warmups=16,
                         processes=total_runs//runs_per_process)
    vals = list(range(256))  # length of str_a
    for delta in vals:
        runner.timeit("hmac split delta={0:#04x}".format(delta),
                      fun,
                      setup=setup.format(delta))
