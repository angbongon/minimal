#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** GET BROTLI BEGIN ***"

# Read the 'FLWM_SOURCE_URL' property from '.config'.
DOWNLOAD_URL=`read_property BROTLI_SOURCE_URL`

# Grab everything after the last '/' character.
ARCHIVE_FILE=${DOWNLOAD_URL##*/}

# Download flwm source archive in the 'source' directory.
download_source $DOWNLOAD_URL $SOURCE_DIR/$ARCHIVE_FILE

# Extract the flwm sources in the 'work/flwm' directory.
extract_source $SOURCE_DIR/$ARCHIVE_FILE brotli

# We go back to the main MLL source folder.
cd $SRC_DIR

echo "*** GET BROTLI END ***"
