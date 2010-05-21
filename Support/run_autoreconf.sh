#!/bin/bash

cd $TM_PROJECT_DIRECTORY
export LIBTOOLIZE="/usr/bin/glibtoolize"

autoreconf -i
retcod=$?
if [[ $retcode -ne 0 ]]; then
    echo "Error: Failed in call to 'autoreconf -i'."
    echo ""
    exit $retcode
else
	echo "Successfully called 'autoreconf -i'."
	echo ""
fi

exit 0
