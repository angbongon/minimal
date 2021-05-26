#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD FLTK BEGIN ***"

# Prepare the install area, e.g. 'work/fltk/fltk_installed'.
echo "Preparing fltk install area. This may take a while."
rm -rf $FLTK_INSTALLED
mkdir $FLTK_INSTALLED

# Find the fltk source directory, e.g. 'fltk-2.23' and remember it.
FLTK_SRC=`ls -d $WORK_DIR/fltk/fltk-*`

# All fltk work is done from the working area.
cd $FLTK_SRC

rm -rf build
mkdir build
cd build

echo "Configuring fltk."
cmake -D OPTION_BUILD_SHARED_LIBS=ON -D CMAKE_INSTALL_PREFIX= ..

# Compile fltk with optimization for "parallel jobs" = "number of processors".
echo "Building fltk."
make -j $NUM_JOBS

# Install fltk in the installation area, e.g. 'work/fltk/fltk_installed'.
echo "Installing fltk."
make install \
  DESTDIR=$FLTK_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD FLTK END ***"
