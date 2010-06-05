#!/bin/bash

cd $TM_PROJECT_DIRECTORY
export LIBTOOLIZE="/usr/bin/glibtoolize"

./configure --target=i386-mingw32 --host=i386-mingw32
retcode=$?
if [[ $retcode -ne 0 ]]; then
    echo "Error: Failed in call to './configure --target=i386-mingw32 --host=i386-mingw32'."
    echo ""
    exit $retcode
else
	echo "Successfully called './configure --target=i386-mingw32 --host=i386-mingw32'."
	echo ""
fi

exit 0
