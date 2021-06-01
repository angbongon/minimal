#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD GLIB BEGIN ***"

# Prepare the install area, e.g. 'work/glib/glib_installed'.
echo "Preparing glib install area. This may take a while."
rm -rf $GLIB_INSTALLED
mkdir $GLIB_INSTALLED

# Find the glib source directory, e.g. 'glib-2.23' and remember it.
GLIB_SRC=`ls -d $WORK_DIR/glib/glib-*`

# All glib work is done from the working area.
cd $GLIB_SRC

rm -rf build
mkdir build
cd build

# Compile glib with optimization for "parallel jobs" = "number of processors".
echo "Building glib."
meson --prefix=$GLIB_INSTALLED -Dbenchmark=disabled && ninja

# Install glib in the installation area, e.g. 'work/glib/glib_installed'.
echo "Installing glib."
ninja install

cd $SRC_DIR

echo "*** BUILD GLIB END ***"
