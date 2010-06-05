#!/usr/bin/env ruby -w

# Handle all the propery formatting so that when command output is displayed
# it is styled appropriately by TextMate.

STDOUT.sync = true

puts "<pre>"

while line = STDIN.gets
  corrected_line = line.gsub("\n", "<br>")
  print corrected_line
end

puts "</pre>"