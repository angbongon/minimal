#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD PCRE BEGIN ***"

# Prepare the work area, e.g. 'work/pcre/pcre_objects'.
echo "Preparing pcre object area. This may take a while."
rm -rf $PCRE_OBJECTS
mkdir $PCRE_OBJECTS

# Prepare the install area, e.g. 'work/pcre/pcre_installed'.
echo "Preparing pcre install area. This may take a while."
rm -rf $PCRE_INSTALLED
mkdir $PCRE_INSTALLED

# Find the pcre source directory, e.g. 'pcre-2.23' and remember it.
PCRE_SRC=`ls -d $WORK_DIR/pcre/pcre-*`

# All pcre work is done from the working area.
cd $PCRE_OBJECTS

echo "Configuring pcre."
$PCRE_SRC/configure \
  --prefix= \
  --disable-werror \
  --disable-static \
  CFLAGS="$CFLAGS"

# Compile pcre with optimization for "parallel jobs" = "number of processors".
echo "Building pcre."
make -j $NUM_JOBS

# Install pcre in the installation area, e.g. 'work/pcre/pcre_installed'.
echo "Installing pcre."
make install \
  DESTDIR=$PCRE_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD PCRE END ***"
