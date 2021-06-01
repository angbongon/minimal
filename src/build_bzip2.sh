#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD BZIP2 BEGIN ***"

# Prepare the install area, e.g. 'work/bzip2/bzip2_installed'.
echo "Preparing bzip2 install area. This may take a while."
rm -rf $BZIP2_INSTALLED
mkdir $BZIP2_INSTALLED

# Find the bzip2 source directory, e.g. 'bzip2-2.23' and remember it.
BZIP2_SRC=`ls -d $WORK_DIR/bzip2/bzip2-*`

# All bzip2 work is done from the working area.
cd $BZIP2_SRC

# Compile bzip2 with optimization for "parallel jobs" = "number of processors".
echo "Building bzip2."
make -f Makefile-libbz2_so \
  -j $NUM_JOBS
make -j $NUM_JOBS

# Install bzip2 in the installation area, e.g. 'work/bzip2/bzip2_installed'.
echo "Installing bzip2."
make install \
  PREFIX=$BZIP2_INSTALLED \
  -j $NUM_JOBS

cp -a libbz2.so.* $BZIP2_INSTALLED/lib

cd $SRC_DIR

echo "*** BUILD BZIP2 END ***"
