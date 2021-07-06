#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD XORG BEGIN ***"

# Prepare the work area, e.g. 'work/xorg/xorg_objects'.
echo "Preparing xorg object area. This may take a while."
rm -rf $XORG_OBJECTS
mkdir $XORG_OBJECTS

# Prepare the install area, e.g. 'work/xorg/xorg_installed'.
echo "Preparing xorg install area. This may take a while."
rm -rf $XORG_INSTALLED
mkdir $XORG_INSTALLED

# Find the xorg source directory, e.g. 'xorg-2.23' and remember it.
XORG_SRC=`ls -d $WORK_DIR/xorg/xorg-server-*`

# All xorg work is done from the working area.
cd $XORG_OBJECTS

$XORG_SRC/configure \
  --disable-config-udev \
  --disable-config-udev-kms \
  --disable-dri \
  --disable-dri2 \
  --disable-dri3 \
  --disable-libdrm \
  --disable-glamor \
  --disable-glx \
  --disable-vbe \
  --disable-libunwind \
  --disable-systemd-logind \
  --disable-xnest \
  --disable-xshmfence \
  --disable-xvfb \
  --disable-xwayland \
  --enable-suid-wrapper \
  --prefix= \
  --without-systemd-daemon 

# Compile fltk with optimization for "parallel jobs" = "number of processors".
echo "Building xorg."
make -j $NUM_JOBS

# Install xorg in the installation area, e.g. 'work/xorg/xorg_installed'.
echo "Installing xorg."
make install \
  DESTDIR=$XORG_INSTALLED \
  -j $NUM_JOBS

cd $SRC_DIR

echo "*** BUILD XORG END ***"
