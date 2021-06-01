#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD HARFBUZZ BEGIN ***"

# Prepare the install area, e.g. 'work/harfbuzz/harfbuzz_installed'.
echo "Preparing harfbuzz install area. This may take a while."
rm -rf $HARFBUZZ_INSTALLED
mkdir $HARFBUZZ_INSTALLED

# Find the harfbuzz source directory, e.g. 'harfbuzz-2.23' and remember it.
HARFBUZZ_SRC=`ls -d $WORK_DIR/harfbuzz/harfbuzz-*`

# All harfbuzz work is done from the working area.
cd $HARFBUZZ_SRC

rm -rf build
mkdir build
cd build

echo "Configuring harfbuzz."
meson --prefix=$HARFBUZZ_INSTALLED -Dbenchmark=disabled && ninja

# Compile harfbuzz with optimization for "parallel jobs" = "number of processors".
echo "Building harfbuzz."
ninja install

cd $SRC_DIR

echo "*** BUILD HARFBUZZ END ***"
