import perf

setup = """
from hmac import compare_digest

str_a = b'YYYYYYYYYYYYYY'

str_b = b''.join((str_a[:{0}], b'X' * (14 - {0})))

assert len(str_a) == len(str_b)
assert len(str_a) == 14
"""

fun = """compare_digest(str_a, str_b)"""

if __name__ == "__main__":
    total_runs = 128
    runs_per_process = 4
    runner = perf.Runner(values=runs_per_process,
                         warmups=64,
                         processes=total_runs//runs_per_process)
    vals = reversed(range(14))  # length of str_a
    for delta in vals:
        runner.timeit("compare_digest delta={0:#04x}".format(delta),
                      fun,
                      setup=setup.format(delta))
