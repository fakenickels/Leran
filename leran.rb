#!/usr/bin/env ruby
# Bill Hotter/I goes/go to learn!
require "fileutils"
class Leran
	@@fileTypes = {
			'Video'		=> 
		%w(.AVI .MKV .MP4 .MPEG .MPG .VOB .RMVB .WMV .FLV .MOV),

			'Music'		=> 
		%w(.MP3 .AMR .WAV .WMA .ACC .OGG),

			'Img'		=> 
		%w(.JPG .JPEG .BMP .PNG .GIF .ICO .PSD .XCF),

			'Docs'		=>
		%w(.ODT .DOC .DOCX .XLS .XLSX .PPSX .PPS .PDF),

			'Others'	=> 
		%w(.TXT .RAR .ZIP .TAR .TAR.GZ .TAR.BZ2 .EXE .TORRENT)
	}

	@@types = @@fileTypes.keys
	
	# Firt step: Get the 'from'/'to' folders
	# def scanFolder: Find folders and files
	# def moveFile: do... duhhhh
	
	def initialize( fromDir, toDir, isDeep )
		@qtMoveds = 0
		toDir = fromDir if toDir == "-e"
		puts "_" * 50 
		puts "Entering the store directory and creating folders"
		scanFolder fromDir,toDir,isDeep
	end
	
	def scanFolder( from,to,deep )
		Dir.foreach( from ) do |file|
			if !File.directory? "#{from}/#{file}" 
				ext = File.extname( file ).upcase
				moveFile from,to,file,ext if ext != ""
			elsif deep == '-d' || !file =~ /^\.{1,2}/ # ignore dirs '.' and '..'
				scanFolder "#{from}/#{file}",to,'-d'  if !(@@types.include? file)
			end		
		end
	end

	def moveFile( from,to,file,ext )
		@@fileTypes.each_key do | type |
			if @@fileTypes[type].include? ext
				puts "Moving: #{file.slice(0,20)}... | Type: #{type}" 
				
				# First: Create the folder for type
				# Second: Create the folder for extension
				# Three: Move the files				
				
				Dir.mkdir "#{to}/#{type}",0755 if !File::exists? "#{to}/#{type}"
				Dir.mkdir "#{to}/#{type}/#{ext}",0755 if !File::exists? "#{to}/#{type}/#{ext}"
				FileUtils.mv "#{from}/#{file}", "#{to}/#{type}/#{ext}"
				@qtMoveds += 1
			end			
		end
	end
	
	def totalMoveds
		@qtMoveds
	end
	
end

# Initialize it!

if ARGV[0] == "help" || ARGV[0] == nil
	puts "Use demonstration: 
		leran.rb fromDir toDir [isDeep]
		fromDir => the desorganized directory
		toDir => the directory for to move the organized files
		if toDir == -e he assumes the fromDir value
		isDeep => find for archives in fromDir subfolders. For yes, use -d
		Enjoy it!"
else
	goNow = Leran.new ARGV[0],ARGV[1],ARGV[2]
	
	puts "Organized files counter: #{goNow.totalMoveds}
		Finished! \n -Script by Bill Hotter
		Press Enter to close..."
	STDIN.readline
end					