#!/bin/sh
set -eux

SRC=${1}
BIN=${SRC%.c}
ODIR=${SRC%.c}.d
DATA=${SRC%.c}.data
IDIR=$(mktemp -d /tmp/XXXXXXXX.afl)

mkdir -p "${ODIR}"
cp "${DATA}" "${IDIR}"

hexdump() {
 od -tx1 -tc -v
}

<"${DATA}" hexdump
gcc "${SRC}" -o "${BIN}"
"${BIN}" "${DATA}" |hexdump
