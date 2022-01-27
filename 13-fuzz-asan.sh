#!/bin/sh
set -eux

SRC=${1}
BIN=${SRC%.c}
ODIR=${SRC%.c}.d
DATA=${SRC%.c}.data
IDIR=$(mktemp -d /tmp/XXXXXXXX.afl)

mkdir -p "${ODIR}"
cp "${DATA}" "${IDIR}"

./afl-2.52b/afl-gcc -m32 "${SRC}" -o "${BIN}" \
 -fsanitize=address
"${BIN}" "${DATA}"

AFL_SKIP_CPUFREQ=1 ./afl-2.52b/afl-fuzz -i "${IDIR}" -o "${ODIR}" -- "${BIN}" @@
