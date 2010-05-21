#!/bin/bash

cd $TM_PROJECT_DIRECTORY
export LIBTOOLIZE="/usr/bin/glibtoolize"

"$TM_BUNDLE_SUPPORT/run_autoreconf.sh"
retcode=$?
if [[ $retcode -ne 0 ]]; then
    exit $retcode
fi

echo "<br>"

"$TM_BUNDLE_SUPPORT/run_configure_mingw.sh"
retcode=$?
if [[ $retcode -ne 0 ]]; then
    exit $retcode
fi

echo "<br>"

"$TM_BUNDLE_SUPPORT/run_make.sh"
retcode=$?
if [[ $retcode -ne 0 ]]; then
    exit $retcode
fi

echo "<br>"

echo "Successfully Built Project!"
echo ""

exit 0
