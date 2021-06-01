#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD ZLIB BEGIN ***"

# Prepare the work area, e.g. 'work/zlib/zlib_objects'.
echo "Preparing zlib object area. This may take a while."
rm -rf $ZLIB_OBJECTS
mkdir $ZLIB_OBJECTS

# Prepare the install area, e.g. 'work/zlib/zlib_installed'.
echo "Preparing zlib install area. This may take a while."
rm -rf $ZLIB_INSTALLED
mkdir $ZLIB_INSTALLED

# Find the zlib source directory, e.g. 'zlib-2.23' and remember it.
ZLIB_SRC=`ls -d $WORK_DIR/zlib/zlib-*`

# All zlib work is done from the working area.
cd $ZLIB_OBJECTS

echo "Configuring zlib."
$ZLIB_SRC/configure \
  --prefix= \

# Compile zlib with optimization for "parallel jobs" = "number of processors".
echo "Building zlib."
make -j $NUM_JOBS

# Install zlib in the installation area, e.g. 'work/zlib/zlib_installed'.
echo "Installing zlib."
make install \
  DESTDIR=$ZLIB_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD ZLIB END ***"
