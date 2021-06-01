#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** GET FREETYPE BEGIN ***"

# Read the 'FREETYPE_SOURCE_URL' property from '.config'.
DOWNLOAD_URL=`read_property FREETYPE_SOURCE_URL`

# Grab everything after the last '/' character.
ARCHIVE_FILE=${DOWNLOAD_URL##*/}

# Download freetype source archive in the 'source' directory.
download_source $DOWNLOAD_URL $SOURCE_DIR/$ARCHIVE_FILE

# Extract the freetype sources in the 'work/freetype' directory.
extract_source $SOURCE_DIR/$ARCHIVE_FILE freetype

# We go back to the main MLL source folder.
cd $SRC_DIR

echo "*** GET FREETYPE END ***"
