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

$qtMoveds = 0;
$types = $fileTypes.keys
# Firts step: Gets the 'from'/'to' folders
def init
	puts "Put the work directory"
	fromDir = gets.chop

	puts "Put the local where the files will be storeds" 
	toDir = gets.chop
	toDir = fromDir if toDir == "."

	puts "Deep scan (inclue subfolders)? (y/n)"
	isDeep = gets.chop;

	puts "_" * 50 
	puts "Entering the store directory and creating folders"
	scanFolder fromDir,toDir,isDeep
end
# Finds folders and files
def scanFolder( from,to,deep )
	Dir.foreach( from ) { |file|
		if !File.directory? "#{from}/#{file}" 
			ext = File.extname( file ).upcase
			moveFile from,to,file,ext if ext != ""
		elsif deep == 'y' && file != '.' && file != '..'
			scanFolder "#{from}/#{file}",to,'y'  if !($types.include? file)
		end		
	} 
end
# def moveFile do... duhhhhh
def moveFile( from,to,file,ext )
	$fileTypes.each_key { | type |
		if $fileTypes[type].include? ext
			puts "Moving: #{file.slice(0,20)}... | Type: #{type}"
			# The folder for type 
			Dir.mkdir "#{to}/#{type}",0000 if !File::exists? "#{to}/#{type}"
			# The folder for extension
			Dir.mkdir "#{to}/#{type}/#{ext}",0000 if !File::exists? "#{to}/#{type}/#{ext}"
			# Moves the files
			FileUtils.mv "#{from}/#{file}", "#{to}/#{type}/#{ext}"
			$qtMoveds += 1
		end			
	}
end
# Initialize it!
init()

puts "Organized files counter: #{$qtMoveds}"
puts "Finished! \n -Script by Bill Hotter"						