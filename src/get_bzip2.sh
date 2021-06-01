#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** GET BZIP2 BEGIN ***"

# Read the 'BZIP2_SOURCE_URL' property from '.config'.
DOWNLOAD_URL=`read_property BZIP2_SOURCE_URL`

# Grab everything after the last '/' character.
ARCHIVE_FILE=${DOWNLOAD_URL##*/}

# Download bzip2 source archive in the 'source' directory.
download_source $DOWNLOAD_URL $SOURCE_DIR/$ARCHIVE_FILE

# Extract the bzip2 sources in the 'work/bzip2' directory.
extract_source $SOURCE_DIR/$ARCHIVE_FILE bzip2

# We go back to the main MLL source folder.
cd $SRC_DIR

echo "*** GET BZIP2 END ***"
