#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD NETTLE BEGIN ***"

# Prepare the work area, e.g. 'work/nettle/nettle_objects'.
echo "Preparing nettle object area. This may take a while."
rm -rf $NETTLE_OBJECTS
mkdir $NETTLE_OBJECTS

# Prepare the install area, e.g. 'work/nettle/nettle_installed'.
echo "Preparing nettle install area. This may take a while."
rm -rf $NETTLE_INSTALLED
mkdir $NETTLE_INSTALLED

# Find the nettle source directory, e.g. 'nettle-2.23' and remember it.
NETTLE_SRC=`ls -d $WORK_DIR/nettle/nettle-*`

# All nettle work is done from the working area.
cd $NETTLE_OBJECTS

$NETTLE_SRC/configure \
  --prefix= \

# Compile fltk with optimization for "parallel jobs" = "number of processors".
echo "Building nettle."
make -j $NUM_JOBS

# Install nettle in the installation area, e.g. 'work/nettle/nettle_installed'.
echo "Installing nettle."
make install \
  DESTDIR=$NETTLE_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD NETTLE END ***"
