import perf

setup = """
val_a = {0}

val_b = {1}
"""

fun = """val_a ^ val_b"""

if __name__ == "__main__":
    total_runs = 32
    runs_per_process = 4
    runner = perf.Runner(values=runs_per_process,
                         warmups=16,
                         processes=total_runs//runs_per_process)
    for a in range(256):
        for b in range(256):
           runner.timeit("xor a={0:#04x} b={1:#04x}".format(a, b),
                         fun,
                         setup=setup.format(a, b))
