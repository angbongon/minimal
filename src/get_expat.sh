#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** GET EXPAT BEGIN ***"

# Read the 'EXPAT_SOURCE_URL' property from '.config'.
DOWNLOAD_URL=`read_property EXPAT_SOURCE_URL`

# Grab everything after the last '/' character.
ARCHIVE_FILE=${DOWNLOAD_URL##*/}

# Download expat source archive in the 'source' directory.
download_source $DOWNLOAD_URL $SOURCE_DIR/$ARCHIVE_FILE

# Extract the expat sources in the 'work/expat' directory.
extract_source $SOURCE_DIR/$ARCHIVE_FILE expat

# We go back to the main MLL source folder.
cd $SRC_DIR

echo "*** GET EXPAT END ***"
