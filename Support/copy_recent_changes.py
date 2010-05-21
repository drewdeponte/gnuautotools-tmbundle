#!/usr/bin/env python

import os
import sys
import re

matched_sec_header = None
matched_first_entry = None
loop_flag = 1

proj_dir = os.getenv('TM_PROJECT_DIRECTORY')

# Look for the ChangeLog or CHANGELOG file in the projects root directory.
changelog_path = proj_dir + "/ChangeLog"
try:
    os.stat(changelog_path)
except:
    changelog_path = proj_dir + "/CHANGELOG"
    try:
        os.stat(changelog_path)
    except:
            print "Error: Failed to stat (" + str(changelog_path) + ")."
            sys.exit(1)
    print "Error: Failed to stat (" + str(changelog_path) + ")."
    sys.exit(2)

# Open the file and identify the changes between ChangeLog section headers and load them into a variable.
try:
    changelog_file = open(changelog_path, 'r')
except:
    print "Error: Failed to open and read " + changelog_path
    sys.exit(3)

changelog_entries = ""
changelog_str = changelog_file.readline()    
while (changelog_str):
    m = re.match('^\d\d\d\d-\d\d-\d\d\s[\w|\s]+\s<.*>$\n?', changelog_str)
    if (m):
        if (matched_sec_header != None):
            break;
        else:
            matched_sec_header = 1
    else:
        em = re.match('^\*.*$\n?', changelog_str)
        if (em):
            if (matched_first_entry):
                changelog_entries += "\n\n" + changelog_str.strip()
            else:
                changelog_entries += changelog_str.strip()
                matched_first_entry = 1
    changelog_str = changelog_file.readline()

changelog_file.close()

# Load the clipboard (pasteboard) with the changes from the variable.
os.system('echo -n "' + str(changelog_entries) + '" | pbcopy')

