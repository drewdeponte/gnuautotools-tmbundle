#!/bin/bash

cd $TM_PROJECT_DIRECTORY
export LIBTOOLIZE="/usr/bin/glibtoolize"

make bundle
retcode=$?
if [[ $retcode -ne 0 ]]; then
    echo "Error: Failed in call to 'make bundle'."
    echo ""
    exit $retcode
else
	echo "Successfully called 'make bundle'."
	echo ""
fi

exit 0
