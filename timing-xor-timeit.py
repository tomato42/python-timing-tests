import timeit
import sys
import math


setup = """
val_a = {0}

val_b = {1}
"""


fun = """val_a ^ val_b"""


def std_dev(vals):
    avg = sum(vals)/len(vals)
    sum_sq = sum((i - avg)**2 for i in vals)
    return math.sqrt(sum_sq / (len(vals) - 1))


if __name__ == "__main__":
    total_runs = 20
    runs_per_process = 4
    warmups = 16

    runner = timeit.Timer(fun, setup=setup.format(0, 0))
    number, delay = runner.autorange()

    print("will do {0} iterations per process, expecting {1:7.2} s per process"
          .format(number, delay), file=sys.stderr)
    print("warmups:", file=sys.stderr, end='')
    sys.stderr.flush()
    for _ in range(warmups):
        timeit.repeat(fun, setup=setup.format(0, 0), repeat=1,
                      number=number)
        print(".", file=sys.stderr, end='')
        sys.stderr.flush()
    print(file=sys.stderr)

    for a in range(256):
        for b in range(256):
            res = []        
            for _ in range(total_runs//runs_per_process):
                # drop the first result as a local warmup
                res.extend(i / number for i in
                           timeit.repeat(fun, setup=setup.format(a, b),
                                         repeat=runs_per_process + 1,
                                         number=number)[1:])
                print(".", file=sys.stderr, end='')
                sys.stderr.flush()
            print(file=sys.stderr)
            print("xor a={0:#04x} b={1:#04x} "
                  "Mean +- std dev: {2:8.4} +- {3:8.4}"
                  .format(a, b, sum(res)/len(res), std_dev(res)),
                  file=sys.stderr)
            print(", ".join(str(i) for i in res))
