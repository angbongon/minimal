#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** GENERATE ROOTFS BEGIN ***"

echo "Preparing rootfs work area. This may take a while."
# Copy all rootfs resources to the location of our 'rootfs' folder.
rm -rf $ROOTFS

# Copy all Busybox generated stuff to the location of our 'rootfs' folder.
cp -r $BUSYBOX_INSTALLED $ROOTFS

cp -r $SRC_DIR/minimal_rootfs/* $ROOTFS

cp $BZIP2_INSTALLED/lib/* $ROOTFS/lib

cp $BROTLI_INSTALLED/lib/libbrotlidec.so.1 $ROOTFS/lib
cp $BROTLI_INSTALLED/lib/libbrotlicommon.so.1 $ROOTFS/lib

cp -r $FONTCONFIG_INSTALLED/lib/*.so* $ROOTFS/lib

cp $X_INSTALLED/lib/*.so* $ROOTFS/lib

cp $GCC_INSTALLED/lib64/libgcc_s.so $ROOTFS/lib
cp $GCC_INSTALLED/lib64/libgcc_s.so.1 $ROOTFS/lib
cp $GCC_INSTALLED/lib64/libstdc++.so $ROOTFS/lib
cp $GCC_INSTALLED/lib64/libstdc++.so.6 $ROOTFS/lib
cp $GCC_INSTALLED/lib64/libstdc++.so.6.0.28 $ROOTFS/lib

cp $LIBUUID_INSTALLED/lib/libuuid.so $ROOTFS/lib
cp $LIBUUID_INSTALLED/lib/libuuid.so.1 $ROOTFS/lib
 
cp -r $EXPAT_INSTALLED/lib/*.so* $ROOTFS/lib

cp $FREETYPE_INSTALLED/lib/libfreetype.so $ROOTFS/lib
cp $FREETYPE_INSTALLED/lib/libfreetype.so.6 $ROOTFS/lib

cp $LIBBSD_INSTALLED/lib/libbsd.so $ROOTFS/lib
cp $LIBBSD_INSTALLED/lib/libbsd.so.0 $ROOTFS/lib

cp $GLIB_INSTALLED/lib/libglib-2.0.so $ROOTFS/lib
cp $GLIB_INSTALLED/lib/libglib-2.0.so.0 $ROOTFS/lib

cp -r $LIBPNG_INSTALLED/lib/libpng.so $ROOTFS/lib
cp -r $LIBPNG_INSTALLED/lib/libpng16.so $ROOTFS/lib
cp -r $LIBPNG_INSTALLED/lib/libpng16.so.16 $ROOTFS/lib
cp -r $LIBPNG_INSTALLED/lib/libpng16.so.16.37.0 $ROOTFS/lib

cp $FLTK_INSTALLED/lib/libfltk.so $ROOTFS/lib
cp $FLTK_INSTALLED/lib/libfltk.so.1.3 $ROOTFS/lib
cp $FLTK_INSTALLED/lib/libfltk_forms.so $ROOTFS/lib
cp $FLTK_INSTALLED/lib/libfltk_forms.so.1.3 $ROOTFS/lib
cp $FLTK_INSTALLED/lib/libfltk_images.so $ROOTFS/lib
cp $FLTK_INSTALLED/lib/libfltk_images.so.1.3 $ROOTFS/lib

cp -r $FLWM_INSTALLED/* $ROOTFS

cp $ZLIB_INSTALLED/lib/libz.so $ROOTFS/lib
cp $ZLIB_INSTALLED/lib/libz.so.1 $ROOTFS/lib

cp $HARFBUZZ_INSTALLED/lib/libharfbuzz.so $ROOTFS/lib
cp $HARFBUZZ_INSTALLED/lib/libharfbuzz.so.0 $ROOTFS/lib
# Delete the '.keep' files which we use in order to keep track of otherwise:W

# empty folders.
find $ROOTFS/* -type f -name '.keep' -exec rm {} +

# Remove 'linuxrc' which is used when we boot in 'RAM disk' mode.
rm -f $ROOTFS/linuxrc

# This is for the dynamic loader. Note that the name and the location are both
# specific for 32-bit and 64-bit machines. First we check the Busybox executable
# and then we copy the dynamic loader to its appropriate location.
BUSYBOX_ARCH=$(file $ROOTFS/bin/busybox | cut -d' ' -f3)
if [ "$BUSYBOX_ARCH" = "64-bit" ] ; then
  mkdir -p $ROOTFS/lib64
  cp $SYSROOT/lib/ld-linux* $ROOTFS/lib64
  echo "Dynamic loader is accessed via '/lib64'."
else
  cp $SYSROOT/lib/ld-linux* $ROOTFS/lib
  echo "Dynamic loader is accessed via '/lib'."
fi

# Copy all necessary 'glibc' libraries to '/lib' BEGIN.

# Busybox has direct dependencies on these libraries.
cp $SYSROOT/lib/libm.so.6 $ROOTFS/lib
cp $SYSROOT/lib/libc.so.6 $ROOTFS/lib
cp $SYSROOT/lib/libresolv.so.2 $ROOTFS/lib

cp $SYSROOT/lib/libpthread.so $ROOTFS/lib
cp $SYSROOT/lib/libpthread.so.0 $ROOTFS/lib
cp $SYSROOT/lib/libpthread-2.33.so $ROOTFS/lib

# Copy all necessary 'glibc' libraries to '/lib' END.

echo "Reducing the size of libraries and executables."
set +e
strip -g \
  $ROOTFS/bin/* \
  $ROOTFS/sbin/* \
  $ROOTFS/lib/* \
  2>/dev/null
set -e

# Read the 'OVERLAY_LOCATION' property from '.config'
OVERLAY_LOCATION=`read_property OVERLAY_LOCATION`

if [ "$OVERLAY_LOCATION" = "rootfs" ] && \
   [ -d $OVERLAY_ROOTFS ] && \
   [ ! "`ls -A $OVERLAY_ROOTFS`" = "" ] ; then

  echo "Merging overlay software in rootfs."

  # With '--remove-destination' all possibly existing soft links in
  # $OVERLAY_ROOTFS will be overwritten correctly.
  cp -r --remove-destination \
    $OVERLAY_ROOTFS/* $ROOTFS
  cp -r --remove-destination \
    $SRC_DIR/minimal_overlay/rootfs/* $ROOTFS
fi

echo "The rootfs area has been generated."

cd $SRC_DIR

echo "*** GENERATE ROOTFS END ***"
