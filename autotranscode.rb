#!/usr/bin/env ruby

  File.open('/Users/stevenfusco/Desktop/test.log', 'a') { |f|
    ARGV.each do|a|
      f.write("Argument: #{a}\n")
    end
  }


#
# if it's a folder 
# enumerate the contents of the folder to "process()"
# else
# send the file to "process()"


#def process(input_file)
# get lastPathComponent
# if it's mkv
# 
#   ./HandBrakeCLI -i input_file -o '~/movies/appletv/lastPathComponent.m4v' --preset='AppleTV'
#   wait for it 
# check error code

# ftp (output_file)
# Host atv
#	User frontrow
#	HostName appletv.local	
