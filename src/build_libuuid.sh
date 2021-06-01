#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

# Prepare the work area, e.g. 'work/libuuid/libuuid_objects'.
echo "Preparing libuuid object area. This may take a while."
rm -rf $LIBUUID_OBJECTS
mkdir $LIBUUID_OBJECTS

echo "*** BUILD LIBUUID BEGIN ***"

# Prepare the install area, e.g. 'work/libuuid/libuuid_installed'.
echo "Preparing libuuid install area. This may take a while."
rm -rf $LIBUUID_INSTALLED
mkdir $LIBUUID_INSTALLED

# Find the libuuid source directory, e.g. 'libuuid-2.23' and remember it.
LIBUUID_SRC=`ls -d $WORK_DIR/libuuid/libuuid-*`

# All libuuid work is done from the working area.
cd $LIBUUID_OBJECTS

$LIBUUID_SRC/configure \
  --prefix= \
  --disable-static \
  CFLAGS="$CFLAGS"

# Compile libuuid with optimization for "parallel jobs" = "number of processors".
echo "Building libuuid."
make -j $NUM_JOBS

# Install libuuid in the installation area, e.g. 'work/libuuid/libuuid_installed'.
echo "Installing libuuid."
make install \
  DESTDIR=$LIBUUID_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD LIBUUID END ***"
