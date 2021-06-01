#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** GET LIBUUID BEGIN ***"

# Read the 'LIBUUID_SOURCE_URL' property from '.config'.
DOWNLOAD_URL=`read_property LIBUUID_SOURCE_URL`

# Grab everything after the last '/' character.
ARCHIVE_FILE=${DOWNLOAD_URL##*/}

# Download libuuid source archive in the 'source' directory.
download_source $DOWNLOAD_URL $SOURCE_DIR/$ARCHIVE_FILE

# Extract the libuuid sources in the 'work/libuuid' directory.
extract_source $SOURCE_DIR/$ARCHIVE_FILE libuuid

# We go back to the main MLL source folder.
cd $SRC_DIR

echo "*** GET LIBUUID END ***"
