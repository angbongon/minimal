#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

# Prepare the work area, e.g. 'work/fontconfig/fontconfig_objects'.
echo "Preparing fontconfig object area. This may take a while."
rm -rf $FONTCONFIG_OBJECTS
mkdir $FONTCONFIG_OBJECTS

echo "*** BUILD FONTCONFIG BEGIN ***"

# Prepare the install area, e.g. 'work/fontconfig/fontconfig_installed'.
echo "Preparing fontconfig install area. This may take a while."
rm -rf $FONTCONFIG_INSTALLED
mkdir $FONTCONFIG_INSTALLED

# Find the fontconfig source directory, e.g. 'fontconfig-2.23' and remember it.
FONTCONFIG_SRC=`ls -d $WORK_DIR/fontconfig/fontconfig-*`

# All fontconfig work is done from the working area.
cd $FONTCONFIG_OBJECTS

$FONTCONFIG_SRC/configure \
  --prefix= \
  --sysconfdir=/etc \
  --disable-docs \
  --disable-nls \
  --mandir=/usr/share/man \
  CFLAGS="$CFLAGS"

# Compile fontconfig with optimization for "parallel jobs" = "number of processors".
echo "Building fontconfig."
make -j $NUM_JOBS

# Install fontconfig in the installation area, e.g. 'work/fontconfig/fontconfig_installed'.
echo "Installing fontconfig."
make install \
  DESTDIR=$FONTCONFIG_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD FONTCONFIG END ***"
