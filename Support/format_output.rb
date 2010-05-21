#!/usr/bin/env ruby -w

STDOUT.sync = true

puts "<pre>"
#puts "<script type=\"text/javascript\">"
#puts "var newDiv = document.createElement(\"div\");"
#puts "var objDiv = document.getElementById(\"divExample\");"
#puts "newDiv.innerHTML = \"<pre>\""
#puts "objDiv.appendChild(newDiv);"
#puts "</script>"

while line = STDIN.gets
  corrected_line = line.gsub("\n", "<br>")
  print corrected_line
  #puts "<script type=\"text/javascript\">"
  #puts "var newDiv = document.createElement(\"div\");"
  #puts "var objDiv = document.getElementById(\"divExample\");"
  #puts "newDiv.innerHTML = \"" + corrected_line + "\""
  #puts "objDiv.appendChild(newDiv);"
  #puts "objDiv.scrollTop = objDiv.scrollHeight;"
  #puts "</script>"
end

#puts "<script type=\"text/javascript\">"
#puts "newDiv.innerHTML = \"</pre>\""
#puts "objDiv.appendChild(newDiv);"
#puts "objDiv.scrollTop = objDiv.scrollHeight;"
#puts "</script>"

puts "</pre>"