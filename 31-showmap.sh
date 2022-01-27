#!/bin/sh
# Compile and fuzz a program.
set -eux

SRC=${1}
BIN=${SRC%.c}
DATA=${SRC%.c}.data

./afl-2.52b/afl-gcc "${SRC}" -o "${BIN}"

AFL_SKIP_CPUFREQ=1 ./afl-2.52b/afl-analyze -i "${DATA}" -- "${BIN}" @@
