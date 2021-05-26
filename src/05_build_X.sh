#!/bin/sh

set -e

# Load common properties and functions in the current script.
. ./common.sh

echo "*** BUILD X BEGIN ***"

# Prepare the work area, e.g. 'work/X/X_objects'.
echo "Preparing X object area. This may take a while."
rm -rf $X_OBJECTS
mkdir -p $X_OBJECTS

# Prepare the install area, e.g. 'work/X/X_installed'.
echo "Preparing X install area. This may take a while."
rm -rf $X_INSTALLED
mkdir -p $X_INSTALLED

cd $X_OBJECTS

$X_CODE/build.sh $X_INSTALLED \
--modfile $X_CODE/module-list.txt \
--clone \
--confflags --disable-selective-werror 

echo "*** BUILD X END ***"