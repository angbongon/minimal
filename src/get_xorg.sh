#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** GET XORG BEGIN ***"

# Read the 'XORG_SOURCE_URL' property from '.config'.
DOWNLOAD_URL=`read_property XORG_SOURCE_URL`

# Grab everything after the last '/' character.
ARCHIVE_FILE=${DOWNLOAD_URL##*/}

# Download xorg source archive in the 'source' directory.
download_source $DOWNLOAD_URL $SOURCE_DIR/$ARCHIVE_FILE

# Extract the xorg sources in the 'work/xorg' directory.
extract_source $SOURCE_DIR/$ARCHIVE_FILE xorg

# We go back to the main MLL source folder.
cd $SRC_DIR

echo "*** GET XORG END ***"
