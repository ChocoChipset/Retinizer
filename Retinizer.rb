#
#  Created by Hector Zarate (hecktorzr.at.gmail.com) on 29/11/12
#
#  Retinizer.rb
#  Script to prepare image resources for Retina and standard resolutions under iPhone projects.
#

#Some Configuration

require 'rubygems'
require 'RMagick'
require 'fileutils'

retinaFilenameSuffix = "@2x"				# String that will be added to original filenames (if needed)
imageFilenameExtensions = ["png", "jpg", "jpeg"]	# Files with this extensions will be affected by script
SCALE_BY = 0.5						# Scale for standard (non-Retina) images 50%


def resize_retina_image(image_filename)
    
    image_name = File.basename(image_filename)
    
    image = Magick::Image.read(image_filename).first    # Read the image
    new_image = image.scale(SCALE_BY)
    
    if new_image.write(image_filename)                 # Overwrite image file
        puts "Resizing Image (#{SCALE_BY}): #{image_name}"
    else
        puts "Error: Couldn't resize image #{image_name}"
    end
    
end


targetDirectory = ARGV[0] ? ARGV[0] : "./"		# If no argument is supplied we use the current directory (.)

unless targetDirectory.end_with?("/")
    targetDirectory += "/"
end

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

	if imageBasename.end_with?(retinaFilenameSuffix)
		retinaImageFilename = originalImageFilename	# image file already includes @2x suffix
	else
		retinaImageFilename = "#{targetDirectory}#{imageBasename}#{retinaFilenameSuffix}#{File.extname(originalImageFilename)}"
		File.rename(originalImageFilename, retinaImageFilename)
		puts "Renaming: #{File.basename(originalImageFilename)} => #{File.basename(retinaImageFilename)}"
	end
    
    retinaImageBasename = File.basename(retinaImageFilename, ".*")
    
    if retinaImageBasename.length > retinaFilenameSuffix.length # avoiding a filename without name. :S
        standardImageBaseName = retinaImageBasename[0...(retinaImageBasename.length - retinaFilenameSuffix.length)]
        standardImageFilename = "#{targetDirectory}#{standardImageBaseName}#{File.extname(retinaImageFilename)}"
        FileUtils.cp_r(retinaImageFilename, standardImageFilename, :remove_destination => true)
        puts "Coping #{File.basename(retinaImageFilename)} => #{File.basename(standardImageFilename)}"
        resize_retina_image(standardImageFilename)

    else
        puts "Warning: {#originalImageFilename} file name is too short. Coulnd't create standard resolution image."
    end
    
    standardImageFilename = retinaImageFilename

end

