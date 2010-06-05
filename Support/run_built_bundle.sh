#!/bin/bash

esc () {
STR="$1" ruby <<"RUBY"
   str = ENV['STR']
   str = str.gsub(/'/, "'\\\\''")
   str = str.gsub(/[\\"]/, '\\\\\\0')
   print "'#{str}'"
RUBY
}

cd $TM_PROJECT_DIRECTORY

proj_app_bundles=`find . -iname *.app`

app_bundle_array=()

for app_bundle in $proj_app_bundles
do
    app_bundle_array=( ${app_bundle_array[@]} $app_bundle )
done

entry_count=${#app_bundle_array[@]}

if [[ entry_count -le 0 ]]; then
    echo "Error: No Application Bundles Found!"
    echo ""
    exit 1
fi

if [[ entry_count -eq 1 ]]; then
    BIN_TO_RUN=${app_bundle_array[0]}
    open $BIN_TO_RUN
    exit 0
fi

xmldata="<plist version=\"1.0\">
<dict>
    <key>logEntries</key>
    <array>"

for binFilePath in ${app_bundle_array[@]}
do
    xmldata="${xmldata}
        <dict>
            <key>binFilePath</key>
            <string>${binFilePath}</string>
        </dict>"
done

xmldata="${xmldata}
    </array>
</dict>
</plist>"

nib_file="${TM_BUNDLE_SUPPORT}/AutotoolsRunSel.nib"

retdata=`echo ${xmldata} | ${DIALOG} -d '{ autotoolsBinFileArgs = ""; }' -m "${nib_file}" | pl`

if [[ `echo ${retdata} | grep 'returnArgument'` ]];
then
    BIN_TO_RUN=`echo ${retdata} | sed 's/.*returnArgument = "//'`
    BIN_TO_RUN=`echo ${BIN_TO_RUN} | sed 's/";.*//'`

    if [[ `echo ${retdata} | grep 'autotoolsBinFileArgs = "'` ]];
    then
        BIN_ARGS=`echo ${retdata} | sed 's/.*autotoolsBinFileArgs = "//'`
        BIN_ARGS=`echo ${BIN_ARGS} | sed 's/";.*//'`
    else
        BIN_ARGS=`echo ${retdata} | sed 's/.*autotoolsBinFileArgs = //'`
        BIN_ARGS=`echo ${BIN_ARGS} | sed 's/; .*//'`
    fi

    open ${BIN_TO_RUN}
else
    exit 0
fi

exit 0
