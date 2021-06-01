#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

# Prepare the work area, e.g. 'work/freetype/freetype_objects'.
echo "Preparing freetype object area. This may take a while."
rm -rf $FREETYPE_OBJECTS
mkdir $FREETYPE_OBJECTS

echo "*** BUILD FREETYPE BEGIN ***"

# Prepare the install area, e.g. 'work/freetype/freetype_installed'.
echo "Preparing freetype install area. This may take a while."
rm -rf $FREETYPE_INSTALLED
mkdir $FREETYPE_INSTALLED

# Find the freetype source directory, e.g. 'freetype-2.23' and remember it.
FREETYPE_SRC=`ls -d $WORK_DIR/freetype/freetype-*`

# All freetype work is done from the working area.
cd $FREETYPE_OBJECTS

$FREETYPE_SRC/configure \
  --prefix= \
  --disable-static \
  CFLAGS="$CFLAGS"

# Compile freetype with optimization for "parallel jobs" = "number of processors".
echo "Building freetype."
make -j $NUM_JOBS

# Install freetype in the installation area, e.g. 'work/freetype/freetype_installed'.
echo "Installing freetype."
make install \
  DESTDIR=$FREETYPE_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD FREETYPE END ***"
