#!/bin/bash

cd $TM_PROJECT_DIRECTORY
export LIBTOOLIZE="/usr/bin/glibtoolize"

./configure
retcode=$?
if [[ $retcode -ne 0 ]]; then
    echo "Error: Failed in call to './configure'."
    echo ""
    exit $retcode
else
	echo "Successfully called './configure'."
	echo ""
fi

exit 0
