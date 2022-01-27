#!/bin/sh
# Compile and fuzz a program.
set -eux

SRC=${1}
BIN=${SRC%.c}
ODIR=${SRC%.c}.d
DATA=${SRC%.c}.crash
IDIR=$(mktemp -d /tmp/XXXXXXXX.afl)

mkdir -p "${ODIR}"
cp "${DATA}" "${IDIR}"

./afl-2.52b/afl-gcc "${SRC}" -o "${BIN}"

AFL_SKIP_CPUFREQ=1 ./afl-2.52b/afl-fuzz -C -i "${IDIR}" -o "${ODIR}" -- "${BIN}" @@
