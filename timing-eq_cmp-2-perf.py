import perf

setup = """
str_a = b's' * 255

str_b = b''.join((str_a[:{0}], b'X' * (255 - {0})))

assert len(str_a) == len(str_b)
"""

fun = """str_a == str_b"""

if __name__ == "__main__":
    total_runs = 128
    runs_per_process = 4
    runner = perf.Runner(values=runs_per_process,
                         warmups=16,
                         processes=total_runs//runs_per_process)
    vals = list(range(255))  # length of str_a
    for delta in vals:
        runner.timeit("eq_cmp delta={0:#04x}".format(delta),
                      fun,
                      setup=setup.format(delta))
