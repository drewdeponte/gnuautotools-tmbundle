#!/bin/bash

cd $TM_PROJECT_DIRECTORY
export LIBTOOLIZE="/usr/bin/glibtoolize"

make
retcode=$?
if [[ $retcode -ne 0 ]]; then
    echo "Error: Failed in call to 'make'."
    echo ""
    exit $retcode
else
	echo "Successfully called 'make'."
	echo ""
fi

exit 0
