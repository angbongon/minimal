#!/bin/sh

set -e

SRC_DIR=$PWD
CONFIG=$SRC_DIR/.config
SOURCE_DIR=$SRC_DIR/source
WORK_DIR=$SRC_DIR/work
KERNEL_INSTALLED=$WORK_DIR/kernel/kernel_installed
GLIBC_OBJECTS=$WORK_DIR/glibc/glibc_objects
GLIBC_INSTALLED=$WORK_DIR/glibc/glibc_installed
BUSYBOX_INSTALLED=$WORK_DIR/busybox/busybox_installed
SYSROOT=$WORK_DIR/sysroot
ROOTFS=$WORK_DIR/rootfs
OVERLAY_ROOTFS=$WORK_DIR/overlay_rootfs
ISOIMAGE=$WORK_DIR/isoimage
ISOIMAGE_OVERLAY=$WORK_DIR/isoimage_overlay

BZIP2_INSTALLED=$WORK_DIR/bzip2/bzip2_installed

BROTLI_INSTALLED=$WORK_DIR/brotli/brotli_installed

GLIB_INSTALLED=$WORK_DIR/glib/glib_installed

LIBPNG_INSTALLED=$WORK_DIR/libpng/libpng_installed

LIBBSD_INSTALLED=$WORK_DIR/libbsd/libbsd_installed

LIBUUID_INSTALLED=$WORK_DIR/libuuid/libuuid_installed
LIBUUID_OBJECTS=$WORK_DIR/libuuid/libuuid_objects

PCRE_INSTALLED=$WORK_DIR/pcre/pcre_installed
PCRE_OBJECTS=$WORK_DIR/pcre/pcre_objects

ZLIB_INSTALLED=$WORK_DIR/zlib/zlib_installed
ZLIB_OBJECTS=$WORK_DIR/zlib/zlib_objects

FREETYPE_INSTALLED=$WORK_DIR/freetype/freetype_installed
FREETYPE_OBJECTS=$WORK_DIR/freetype/freetype_objects

EXPAT_INSTALLED=$WORK_DIR/expat/expat_installed
EXPAT_OBJECTS=$WORK_DIR/expat/expat_objects

LIBSTDC_INSTALLED=$WORK_DIR/gcc/libstdc_installed
LIBSTDC_OBJECTS=$WORK_DIR/gcc/libstdc_objects

GCC_INSTALLED=$WORK_DIR/gcc/gcc_installed
GCC_OBJECTS=$WORK_DIR/gcc/gcc_objects

LIBGCC_INSTALLED=$WORK_DIR/gcc/libgcc_installed
LIBGCC_OBJECTS=$WORK_DIR/gcc/libgcc_objects

HARFBUZZ_INSTALLED=$WORK_DIR/harfbuzz/harfbuzz_installed
HARFBUZZ_OBJECTS=$WORK_DIR/harfbuzz/harfbuzz_objects

FONTCONFIG_INSTALLED=$WORK_DIR/fontconfig/fontconfig_installed
FONTCONFIG_OBJECTS=$WORK_DIR/fontconfig/fontconfig_objects

X_INSTALLED=$WORK_DIR/X/X_installed
X_OBJECTS=$WORK_DIR/X/X_objects
X_CODE=$PWD/X

FLWM_OBJECTS=$WORK_DIR/flwm/flwm_objects
FLWM_INSTALLED=$WORK_DIR/flwm/flwm_installed
FLTK_OBJECTS=$WORK_DIR/fltk/fltk_objects
FLTK_INSTALLED=$WORK_DIR/fltk/fltk_installed

# This function reads property from the main '.config' file.
#
# Using () instead of {} for the function body is a POSIX
# compliant way to execute subshell and as consequence all
# variables in the function will become effectively in local
# scope. Note that the 'local' keyword is supported by most
# shells but it is not POSIX compliant.
read_property() (
  # The property we are looking for.
  prop_name=$1

  # The value of the property set initially to empty string.
  prop_value=

  if [ ! "$prop_name" = "" ] ; then
    # Search in the main '.config' file.
    prop_value=`grep -i ^${prop_name}= $CONFIG | cut -f2- -d'=' | xargs`
  fi

  echo $prop_value
)

# Read commonly used properties from the main '.config' file.
JOB_FACTOR=`read_property JOB_FACTOR`
CFLAGS=`read_property CFLAGS`
NUM_CORES=$(grep ^processor /proc/cpuinfo | wc -l)

# Calculate the number of 'make' jobs to be used later.
NUM_JOBS=$((NUM_CORES * JOB_FACTOR))

download_source() (
  url=$1  # Download from this URL.
  file=$2 # Save the resource in this file.

  local=`read_property USE_LOCAL_SOURCE`

  if [ "$local" = "true" -a ! -f $file  ] ; then
    echo "Source file '$file' is missing and will be downloaded."
    local=false
  fi

  if [ ! "$local" = "true" ] ; then
    echo "Downloading source file from '$url'."
    echo "Saving source file in '$file'".
    wget -O $file -c $url
  else
    echo "Using local source file '$file'."
  fi
)

extract_source() (
  file=$1
  name=$2

  # Delete folder with previously extracted source.
  echo "Removing '$name' work area. This may take a while."
  rm -rf $WORK_DIR/$name
  mkdir $WORK_DIR/$name

  # Extract source to folder 'work/$source'.
  tar -xvf $file -C $WORK_DIR/$name
)
