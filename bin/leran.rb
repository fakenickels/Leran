#!/usr/bin/env ruby
require 'leran'

# Initialize it!

if ARGV[0] == "help" || ARGV[0] == nil
	puts %q{Use demonstration: 
		leran fromDir toDir [-d]
		
		fromDir => Directory where the desorganized files are
		
		toDir => Directory for to move the organized files
		
		-d => Recursive mode. Find for files in fromDir subfolders
		
		leran /home/gabriel/organizeLater /home/gabriel/my_organized_files -d
		
		Enjoy it!}
else
	goNow = Leran.new ARGV[0],ARGV[1],ARGV[2]
	
	puts "Organized files counter: #{goNow.totalMoveds}
		Finished! \n -Script by Bill Hotter
		Press Enter to close..."
	STDIN.readline
end
