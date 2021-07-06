#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** GET NETTLE BEGIN ***"

# Read the 'NETTLE_SOURCE_URL' property from '.config'.
DOWNLOAD_URL=`read_property NETTLE_SOURCE_URL`

# Grab everything after the last '/' character.
ARCHIVE_FILE=${DOWNLOAD_URL##*/}

# Download nettle source archive in the 'source' directory.
download_source $DOWNLOAD_URL $SOURCE_DIR/$ARCHIVE_FILE

# Extract the nettle sources in the 'work/nettle' directory.
extract_source $SOURCE_DIR/$ARCHIVE_FILE nettle

# We go back to the main MLL source folder.
cd $SRC_DIR

echo "*** GET NETTLE END ***"
