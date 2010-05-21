#!/bin/bash

cd $TM_PROJECT_DIRECTORY
export LIBTOOLIZE="/usr/bin/glibtoolize"

make distclean
retcode=$?
if [[ $retcode -ne 0 ]]; then
    echo "Error: Failed in call to 'make distclean'."
    echo ""
    exit $retcode
else
	echo "Successfully called 'make distclean'."
	echo ""
fi

exit 0
