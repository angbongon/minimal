#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD BROTLI BEGIN ***"

# Prepare the install area, e.g. 'work/brotli/brotli_installed'.
echo "Preparing brotli install area. This may take a while."
rm -rf $BROTLI_INSTALLED
mkdir $BROTLI_INSTALLED

# Find the brotli source directory, e.g. 'brotli-2.23' and remember it.
BROTLI_SRC=`ls -d $WORK_DIR/brotli/brotli-*`

# All brotli work is done from the working area.
cd $BROTLI_SRC

rm -rf out
mkdir out
cd out

echo "Configuring brotli."
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX= ..

# Compile brotli with optimization for "parallel jobs" = "number of processors".
echo "Building brotli."
make -j $NUM_JOBS

# Install brotli in the installation area, e.g. 'work/brotli/brotli_installed'.
echo "Installing brotli."
make install \
  DESTDIR=$BROTLI_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD BROTLI END ***"
