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

am_files=`find . -iname Makefile.am`

myarray=()

for am_file in $am_files
do
    bin_path=`echo $am_file | sed 's/Makefile.am//'`
    bin_names=`grep "_PROGRAMS" ${am_file} | sed 's/.*=//' | tr '\n' ' '`
    for name in $bin_names
    do
        if [ -f $bin_path$name ]; then
            myarray=( ${myarray[@]} $bin_path$name )
        fi
    done
done

entry_count=${#myarray[@]}

if [[ entry_count -le 0 ]]; then
    echo "Error: No Built Binaries Found!"
    echo ""
    exit 1
fi

xmldata="<plist version=\"1.0\">
<dict>
    <key>logEntries</key>
    <array>"

for binFilePath in ${myarray[@]}
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

osascript <<- APPLESCRIPT
    tell app "Terminal"
        launch
        activate
        do script "clear; cd $(esc "${TM_PROJECT_DIRECTORY}"); $(esc "${BIN_TO_RUN}") $(esc "${BIN_ARGS}")"
        set position of first window to { 100, 100 }
    end tell
APPLESCRIPT

else
    exit 0
fi

exit 0
