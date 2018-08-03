import perf

setup = """
from hmac import compare_digest

str_a = b'secret API key'

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
    vals = [13, 5, 4, 6, 9, 12, 2, 8, 1, 10, 3, 11, 7, 0]
    for delta in vals:
        runner.timeit("compare_digest delta={0:#04x}".format(delta),
                      fun,
                      setup=setup.format(delta))
