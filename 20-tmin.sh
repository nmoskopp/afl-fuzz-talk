#!/bin/sh
set -eux

SRC=${1}
BIN=${SRC%.c}
DATA=${SRC%.c}.crash
TMIN=${SRC%.c}.crash_tmin

./afl-2.52b/afl-gcc "${SRC}" -o "${BIN}"

AFL_SKIP_CPUFREQ=1 ./afl-2.52b/afl-tmin -i "${DATA}" -o "${TMIN}" -- "${BIN}"
