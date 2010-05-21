#!/bin/bash

export LIBTOOLIZE="/usr/bin/glibtoolize"
cd ${TM_PROJECT_DIRECTORY}
ruby -e "require ENV['TM_SUPPORT_PATH'] + '/lib/ui'; print TextMate::UI::request_secure_string" | sudo make install
retcode=$?
if [[ $retcode -ne 0 ]]; then
    echo "Error: Failed in call to 'sudo make install'."
    exit $retcode
else
    echo "Successfully called 'sudo make install'."
fi

exit 0
