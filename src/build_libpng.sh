#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD LIBPNG BEGIN ***"

# Prepare the install area, e.g. 'work/libpng/libbsd_installed'.
echo "Preparing libpng install area. This may take a while."
rm -rf $LIBPNG_INSTALLED
mkdir $LIBPNG_INSTALLED

# Find the libpng source directory, e.g. 'libbsd-2.23' and remember it.
LIBPNG_SRC=`ls -d $WORK_DIR/libpng/libpng-*`

# All libpng work is done from the working area.
cd $LIBPNG_SRC

echo "Configuring libpng."
$LIBPNG_SRC/configure \
  --prefix= \
  --disable-werror \
  CFLAGS="$CFLAGS"

# Compile libpng with optimization for "parallel jobs" = "number of processors".
echo "Building libpng."
make -j $NUM_JOBS

# Install libpng in the installation area, e.g. 'work/libbsd/libbsd_installed'.
echo "Installing libpng."
make install \
  DESTDIR=$LIBPNG_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD LIBPNG END ***"
