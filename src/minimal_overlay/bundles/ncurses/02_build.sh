#!/bin/bash

SRC_DIR=$(pwd)

. ../../common.sh

cd $WORK_DIR/overlay/ncurses

DESTDIR="$PWD/ncurses_installed"

# Change to the ncurses source directory which ls finds, e.g. 'ncurses-6.0'.
cd $(ls -d ncurses-*)

echo "Preparing ncurses work area. This may take a while..."
make -j $NUM_JOBS clean

rm -rf $DESTDIR

# Remove static library
sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in
# http://www.linuxfromscratch.org/lfs/view/development/chapter06/ncurses.html

# Configure Ncurses
echo "Configuring Ncurses..."
./configure \
    --prefix=/usr \
    --with-termlib \
    --with-shared \
    --with-terminfo-dirs=/lib/terminfo \
    --with-default-terminfo-dirs=/lib/terminfo \
    --without-normal \
    --without-debug \
    --without-cxx-binding \
    --with-abi-version=5 \
    CFLAGS="-Os -s -fno-stack-protector -U_FORTIFY_SOURCE" \
    CPPFLAGS="-P"

# Most configuration switches are from AwlsomeAlex
# https://github.com/AwlsomeAlex/AwlsomeLinux/blob/59d59730703b058081a2371076a807590cacb31e/src/overlay_ncurses.sh

# CPPFLAGS fixes a bug with Ubuntu 16.04
# https://trac.sagemath.org/ticket/19762

echo "Building ncurses..."
make -j $NUM_JOBS

echo "Installing ncurses..."
make -j $NUM_JOBS install DESTDIR=$DESTDIR

echo "Reducing ncurses size..."
strip -g $DESTDIR/usr/bin/*

ROOTFS="$WORK_DIR/src/minimal_overlay/rootfs"

cp -r $DESTDIR/usr/* $ROOTFS

echo "ncurses has been installed."

cd $SRC_DIR
