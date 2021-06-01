#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** GET GLIB BEGIN ***"

# Read the 'GLIB_SOURCE_URL' property from '.config'.
DOWNLOAD_URL=`read_property GLIB_SOURCE_URL`

# Grab everything after the last '/' character.
ARCHIVE_FILE=${DOWNLOAD_URL##*/}

# Download glib source archive in the 'source' directory.
download_source $DOWNLOAD_URL $SOURCE_DIR/$ARCHIVE_FILE

# Extract the glib sources in the 'work/glib' directory.
extract_source $SOURCE_DIR/$ARCHIVE_FILE glib

# We go back to the main MLL source folder.
cd $SRC_DIR

echo "*** GET GLIB END ***"
