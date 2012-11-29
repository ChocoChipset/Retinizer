#
#  Created by Hector Zarate (hecktorzr.at.gmail.com) on 29/11/12
#
#  Retinizer.rb
#  Script to prepare image resources for Retina and standard resolutions under iPhone projects.

# Some Configuration

retinaFilenameSuffix = "@2x"				# String that will be added to original filenames (if needed)
imageFilenameExtensions = ["png", "jpg", "jpeg"]	# Files with this extensions will be affected by script

targetDirectory = ARGV[0] ? ARGV[0] : "./"		# If no argument is supplied we use the current directory (.)

#TODO: Add '/' if not at the end of targetDirectory

abort ("Error: #{targetDirectory} is not a directory") unless File.directory?(targetDirectory) 

targetFilenames = Array.new

# For each supported extension, add found files to targetFilenames 
imageFilenameExtensions.each do |extension|
	targetFilenames += Dir["#{targetDirectory}*.#{extension}"]
end

puts "Images found in directory: #{targetFilenames.count}"

# Rename all image files to Basename + @2x
targetFilenames.each do |originalImageFilename|
	imageBasename = File.basename(originalImageFilename, ".*")
	unless imageBasename.end_with?(retinaFilenameSuffix)
		newImageFilename = "#{targetDirectory}#{imageBasename}#{retinaFilenameSuffix}#{File.extname(originalImageFilename)}"
		File.rename(originalImageFilename, newImageFilename)
		puts "Renaming: #{originalImageFilename} => #{newImageFilename}"
	end
end
