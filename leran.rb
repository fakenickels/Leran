#!/usr/bin/env ruby
# Bill Hotter/I goes/go to learn!
require "fileutils"

$fileTypes = Hash[
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
]

$types = $fileTypes.keys
class Leran
	# Firt step: Get the 'from'/'to' folders
	def initialize( fromDir, toDir, isDeep )
		@qtMoveds = 0
		toDir = fromDir if toDir == "-e"
		if fromDir == "help"
			puts "#" * 20
			puts "Use demonstration: leran.rb fromDir toDir [isDeep]"
			puts "fromDir => the desorganized directory"
			puts "toDir => the directory for to move the organized files\n",
				"if toDir == -e (dot) he assumes the fromDir value",
				"\n leran.rb /home/user/Docs -e -d"
			puts "isDeep => find for archives in fromDir subfolders. For yes, use -d"
		else
			puts "_" * 50 
			puts "Entering the store directory and creating folders"
			scanFolder fromDir,toDir,isDeep
		end
	end
	# Find folders and files
	def scanFolder( from,to,deep )
		Dir.foreach( from ) do |file|
			if !File.directory? "#{from}/#{file}" 
				ext = File.extname( file ).upcase
				moveFile from,to,file,ext if ext != ""
			elsif deep == '-y' || !file =~ /^\.{1,2}/ # ignore dirs '.' and '..'
				scanFolder "#{from}/#{file}",to,'-y'  if !($types.include? file)
			end		
		end
	end
	# def moveFile do... duhhhhh
	def moveFile( from,to,file,ext )
		$fileTypes.each_key do | type |
			if $fileTypes[type].include? ext
				puts "Moving: #{file.slice(0,20)}... | Type: #{type}"
				# The folder for type 
				Dir.mkdir "#{to}/#{type}",0000 if !File::exists? "#{to}/#{type}"
				# The folder for extension
				Dir.mkdir "#{to}/#{type}/#{ext}",0000 if !File::exists? "#{to}/#{type}/#{ext}"
				# Moves the files
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
	puts "#" * 50
	puts "Use demonstration: \nleran.rb fromDir toDir [isDeep]"
	puts "\nfromDir => the desorganized directory"
	puts "toDir => the directory for to move the organized files\n",
		"if toDir == . (dot) he assumes the fromDir value"
	puts "isDeep => find for archives in fromDir subfolders. For yes, use -d"
	puts "\n Enjoy it!"
else
	goNow = Leran.new ARGV[0],ARGV[1],ARGV[2]
	
	puts "Organized files counter: #{goNow.totalMoveds}"
	puts "Finished! \n -Script by Bill Hotter"
	puts "\nPress Enter to close..."
	STDIN.readline
end					