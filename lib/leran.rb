#!/usr/bin/env ruby
require 'fileutils'

class Leran
	@@fileTypes = {
	
			'Video' =>
		%w(.AVI .MKV .MP4 .MPEG .MPG .VOB .RMVB .WMV .FLV .MOV),

			'Music' =>
		%w(.MP3 .AMR .WAV .WMA .ACC .OGG),

			'Img' =>
		%w(.JPG .JPEG .BMP .PNG .GIF .ICO .PSD .XCF),

			'Docs' =>
		%w(.ODT .DOC .DOCX .XLS .XLSX .PPSX .PPS .PDF),

			'Others' =>
		%w(.TXT .RAR .ZIP .TAR .EXE .TORRENT)
		
	}
	
	@@types = @@fileTypes.keys
	
	# Firt step: Get the 'from'/'to' folders
	# def scanFolder: Find folders and files
	# def moveFile: do... duhhhh
	
	def initialize( fromDir, toDir, isDeep )
		@qtMoveds = 0
		toDir = fromDir if toDir == '-e'
		
		puts '_' * 52 
		puts 'Entering in the store directory and creating folders'
		puts '_' * 52 
		
		scanFolder fromDir, toDir, isDeep	
	end
	
	def scanFolder( from,to,deep )
		Dir.foreach( from ) do |file|
			if !File.directory? "#{from}/#{file}"
				ext = File.extname( file ).upcase
				
				moveFile from,to,file,ext if ext != ""
			elsif deep == '-d' && !file =~ /^\.{1,2}/ # ignore dirs '.' and '..'
				scanFolder( "#{from}/#{file}", to, '-d' ) if !(@@types.include? file)
			end		
		end
	end

	def moveFile( from,to,file,ext )
		@@fileTypes.each_key do | type |
			if @@fileTypes[type].include? ext
				puts "\tMoving: #{file.slice(0,20)}... | Type: #{type}" 
				
				# First: Create the folder for type
				# Second: Create the folder for extension			

				FileUtils::mkdir_p( "#{to}/#{type}" ) if !File.exists? "#{to}/#{type}"
				FileUtils::mkdir_p( "#{to}/#{type}/F#{ext}" ) if !File.exists? "#{to}/#{type}/F#{ext}"

				FileUtils::mv "#{from}/#{file}", "#{to}/#{type}/F#{ext}"

				@qtMoveds += 1
			end			
		end
	end

	def totalMoveds
		@qtMoveds
	end
	
end				
