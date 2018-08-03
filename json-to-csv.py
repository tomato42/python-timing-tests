#!/usr/bin/env python3
import argparse
import csv
import perf
import six
from itertools import chain


def export_csv(args, suite):
    rows = []
    for bench in sorted(suite.get_benchmarks(), key=lambda x: x.get_name()):
        print("converting: {0}".format(bench.get_name()))
        runs = bench.get_runs()
        runs_values = [run.values for run in runs if run.values]

        rows.append(list(chain(*runs_values)))

    if six.PY3:
        fp = open(args.csv_filename, 'w', newline='\n', encoding='ascii')
    else:
        fp = open(args.csv_filename, 'w')
    with fp:
        writer = csv.writer(fp)
        writer.writerows(rows)


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('json_filename')
    parser.add_argument('csv_filename')
    return parser.parse_args()


def main():
    args = parse_args()
    suite = perf.BenchmarkSuite.load(args.json_filename)

    export_csv(args, suite)


if __name__ == "__main__":
    main()
