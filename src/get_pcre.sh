#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** GET PCRE BEGIN ***"

# Read the 'PCRE_SOURCE_URL' property from '.config'.
DOWNLOAD_URL=`read_property PCRE_SOURCE_URL`

# Grab everything after the last '/' character.
ARCHIVE_FILE=${DOWNLOAD_URL##*/}

# Download pcre source archive in the 'source' directory.
download_source $DOWNLOAD_URL $SOURCE_DIR/$ARCHIVE_FILE

# Extract the pcre sources in the 'work/pcre' directory.
extract_source $SOURCE_DIR/$ARCHIVE_FILE pcre

# We go back to the main MLL source folder.
cd $SRC_DIR

echo "*** GET PCRE END ***"
