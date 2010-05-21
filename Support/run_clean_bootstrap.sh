#!/bin/bash

cd $TM_PROJECT_DIRECTORY
export LIBTOOLIZE="/usr/bin/glibtoolize"

if [[ -e "clean_bootstrap.sh" ]]; then
    ./clean_bootstrap.sh
    retcode=$?
    if [[ $retcode -ne 0 ]]; then
        echo "Error: Failed in call to './clean_bootstrap.sh'."
        echo ""
        exit $retcode
    else
	    echo "Successfully called './clean_bootstrap.sh'."
	    echo ""
    fi
else
    echo "Error: No clean_bootstrap.sh script in project top level directory!"
    echo ""
    exit 1
fi

exit 0
