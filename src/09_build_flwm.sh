#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD FLWM BEGIN ***"

# Prepare the install area, e.g. 'work/flwm/flwm_installed'.
echo "Preparing flwm install area. This may take a while."
rm -rf $FLWM_INSTALLED
mkdir $FLWM_INSTALLED

# Find the flwm source directory, e.g. 'flwm-2.23' and remember it.
FLWM_SRC=`ls -d $WORK_DIR/flwm/flwm-*`

# All flwm work is done from the working area.
cd $FLWM_SRC

echo "Configuring flwm."
./configure \
  --prefix= \

# Compile fltk with optimization for "parallel jobs" = "number of processors".
echo "Building flwm."
make -j $NUM_JOBS

# Install flwm in the installation area, e.g. 'work/flwm/flwm_installed'.
echo "Installing flwm."
make install \
  DESTDIR=$FLWM_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD FLWM END ***"
