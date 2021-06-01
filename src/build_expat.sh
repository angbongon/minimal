#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

# Prepare the work area, e.g. 'work/expat/expat_objects'.
echo "Preparing expat object area. This may take a while."
rm -rf $EXPAT_OBJECTS
mkdir $EXPAT_OBJECTS

echo "*** BUILD EXPAT BEGIN ***"

# Prepare the install area, e.g. 'work/expat/expat_installed'.
echo "Preparing expat install area. This may take a while."
rm -rf $EXPAT_INSTALLED
mkdir $EXPAT_INSTALLED

# Find the expat source directory, e.g. 'expat-2.23' and remember it.
EXPAT_SRC=`ls -d $WORK_DIR/expat/expat-*`

# All expat work is done from the working area.
cd $EXPAT_OBJECTS

$EXPAT_SRC/configure \
  --prefix= \
  --disable-static \
  CFLAGS="$CFLAGS"

# Compile expat with optimization for "parallel jobs" = "number of processors".
echo "Building expat."
make -j $NUM_JOBS

# Install expat in the installation area, e.g. 'work/expat/expat_installed'.
echo "Installing expat."
make install \
  DESTDIR=$EXPAT_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD EXPAT END ***"
