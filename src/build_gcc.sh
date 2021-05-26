#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD GCC BEGIN ***"

# Prepare the install area, e.g. 'work/gcc/gcc_installed'.
echo "Preparing gcc install area. This may take a while."
rm -rf $GCC_INSTALLED
mkdir $GCC_INSTALLED

# Find the gcc source directory, e.g. 'gcc-2.23' and remember it.
GCC_SRC=`ls -d $WORK_DIR/gcc/gcc-*`

# All gcc work is done from the working area.
cd $GCC_SRC

rm -rf build
mkdir build
cd build

echo "Configuring gcc."
../configure \
  --prefix= \
  --disable-bootstrap \
  --disable-decimal-float \
  --disable-multilib \
  --disable-nls \
  --disable-threads \
  --disable-werror \
  --disable-gnatools \
  --disable-gotools \
  --disable-intl \
  --disable-libada \
  --disable-libatomic \
  --disable-libcc1 \
  --disable-libgfortran \
  --disable-libgo \
  --disable-libgomp \
  --disable-libhsail-rt \
  --disable-libitm \
  --disable-libobjc \
  --disable-liboffloadmic \
  --disable-libphobos \
  --disable-libquadmath \
  --disable-libquadmath-support \
  --disable-libsanitizer \
  --disable-libssp \
  --disable-libvtv \
  --disable-lto-plugin \
  --disable-zlib \

# Compile gcc with optimization for "parallel jobs" = "number of processors".
echo "Building gcc."
make -j $NUM_JOBS

# Install gcc in the installation area, e.g. 'work/gcc/gcc_installed'.
echo "Installing gcc."
make install \
  DESTDIR=$GCC_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD GCC END ***"
