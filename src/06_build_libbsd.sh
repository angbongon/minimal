#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD LIBBSD BEGIN ***"

# Prepare the install area, e.g. 'work/libbsd/libbsd_installed'.
echo "Preparing libbsd install area. This may take a while."
rm -rf $LIBBSD_INSTALLED
mkdir $LIBBSD_INSTALLED

# Find the libbsd source directory, e.g. 'libbsd-2.23' and remember it.
LIBBSD_SRC=`ls -d $WORK_DIR/libbsd/libbsd-*`

# All libbsd work is done from the working area.
cd $LIBBSD_SRC

echo "Configuring libbsd."
$LIBBSD_SRC/configure \
  --prefix= \
  --disable-werror \
  CFLAGS="$CFLAGS"

# Compile libbsd with optimization for "parallel jobs" = "number of processors".
echo "Building libbsd."
make -j $NUM_JOBS

# Install libbsd in the installation area, e.g. 'work/libbsd/libbsd_installed'.
echo "Installing libbsd."
make install \
  DESTDIR=$LIBBSD_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD LIBBSD END ***"
