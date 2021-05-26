#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD LIBSTDC BEGIN ***"

# Prepare the install area, e.g. 'work/libstdc/libstdc_installed'.
echo "Preparing libstdc install area. This may take a while."
rm -rf $LIBSTDC_INSTALLED
mkdir $LIBSTDC_INSTALLED

# Find the libstdc source directory, e.g. 'libstdc-2.23' and remember it.
LIBSTDC_SRC=`ls -d $WORK_DIR/gcc/gcc-*/libstdc++-*`

# All libstdc work is done from the working area.
cd $LIBSTDC_SRC

rm -rf build
mkdir build
cd build

echo "Configuring libstdc."
../configure \
  --prefix= \
  --disable-werror \
  --disable-multilib \
  --disable-nls \
  --disable-libstdcxx-threads \
  --disable-libstdcxx-pch \
  CFLAGS="$CFLAGS"

# Compile libstdc with optimization for "parallel jobs" = "number of processors".
echo "Building libstdc."
make -j $NUM_JOBS

# Install libstdc in the installation area, e.g. 'work/libstdc/libstdc_installed'.
echo "Installing libstdc."
make install \
  DESTDIR=$LIBSTDC_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD LIBSTDC END ***"
