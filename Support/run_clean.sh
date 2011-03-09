#!/bin/bash

cd $TM_PROJECT_DIRECTORY
export LIBTOOLIZE="/usr/bin/glibtoolize"

"$TM_BUNDLE_SUPPORT/run_make_clean.sh"
retcode=$?
if [[ $retcode -ne 0 ]]; then
    exit $retcode
fi

echo "<br>"

"$TM_BUNDLE_SUPPORT/run_make_distclean.sh"
retcode=$?
if [[ $retcode -ne 0 ]]; then
    exit $retcode
fi

echo "<br>"

"$TM_BUNDLE_SUPPORT/run_clean_bootstrap.sh"
retcode=$?
if [[ $retcode -ne 0 ]]; then
    exit $retcode
fi

echo "<br>"
echo "Successfully Cleaned Project!"
echo ""

exit 0
