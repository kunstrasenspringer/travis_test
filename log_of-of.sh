#!/bin/sh
# Saving used sofware version in a log file

# log file
if [ -f log_of-of ]
then
	rm log_of-of
else
	touch log_of-of
fi

# version of preCICE
PRECICE_VERSION=$(git ls-remote --tags https://github.com/precice/precice.git | cut -d/ -f3 | sort -Vu | tail -1)
PRECICE_VERSION="precice_version: "$PRECICE_VERSION
echo $PRECICE_VERSION >> log_of-of

# version of OpenFOAM
OF_VERSION="OpenFOAM version: 4.1"
echo $OF_VERSION >> log_of-of

# version of Ubunut
Ubuntu_Version="Ubuntu version: 16.04"
echo $Ubuntu_Version >> log_of-of

# version of OpenFOAM-adapter
OF_ADAPTER_VERSION=$(git ls-remote https://github.com/precice/calculix-adapter.git  | cut -d/ -f3 | sort -Vu | tail -1)
OF_ADAPTER_VERSION="OpenFOAM-adapter version: "$OF_ADAPTER_VERSION
echo $OF_ADAPTER_VERSION >> log_of-of
