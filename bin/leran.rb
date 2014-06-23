#!/usr/bin/env ruby
require 'leran'

# Initialize it!

if ARGV[0] == "help" || ARGV[0] == nil
	puts %q{Use demonstration: 
		leran fromDir toDir [-d]
		
			fromDir, the desorganized directory
			toDir, the directory for to move the organized files
			-d, find for archives in fromDir subfolders
		
		Enjoy it!}
else
	goNow = Leran.new ARGV[0],ARGV[1],ARGV[2]
	
	puts "Organized files counter: #{goNow.totalMoveds}
		Finished! \n -Script by Gabriel Rubens
		Press Enter to close..."
	STDIN.readline
end	
