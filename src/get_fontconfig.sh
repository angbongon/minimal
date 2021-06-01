#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** GET FONTCONFIG BEGIN ***"

# Read the 'FONTCONFIG_SOURCE_URL' property from '.config'.
DOWNLOAD_URL=`read_property FONTCONFIG_SOURCE_URL`

# Grab everything after the last '/' character.
ARCHIVE_FILE=${DOWNLOAD_URL##*/}

# Download fontconfig source archive in the 'source' directory.
download_source $DOWNLOAD_URL $SOURCE_DIR/$ARCHIVE_FILE

# Extract the fontconfig sources in the 'work/fontconfig' directory.
extract_source $SOURCE_DIR/$ARCHIVE_FILE fontconfig

# We go back to the main MLL source folder.
cd $SRC_DIR

echo "*** GET FONTCONFIG END ***"
