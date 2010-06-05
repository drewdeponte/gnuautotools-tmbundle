#!/bin/bash

cd $TM_PROJECT_DIRECTORY
export LIBTOOLIZE="/usr/bin/glibtoolize"

make clean
retcode=$?
if [[ $retcode -ne 0 ]]; then
    echo "Error: Failed in call to 'make clean'."
    echo ""
    exit $retcode
else
	echo "Successfully called 'make clean'."
	echo ""
fi

exit 0
