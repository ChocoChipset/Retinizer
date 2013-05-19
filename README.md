Retinizer
=========


## What exactly it does? 
Given a directory path:

1. Will find all "PNG" and "JPG" files in it and, if needed, will add a '@2x' suffix to those filenames.
2. Will write half resolution version of those files. New image files will be named after the original filenames but removing the '@2x' suffix.

## Usage 
1. Install the __RMagick__ gem. [This script](https://github.com/maddox/magick-installer) may help mac users.
    
    ````
    gem install rmagick
    ````

2. Execute Retinizer script. First argument is the directory to operate. If no argument is supplied, operations will take place in current directory. 

    ````
    ruby Retinizer.rb /ExampleDirectory/FullOfImages/
    ````

1. Enjoy Retina and standard resolutions for your iOS projects.

## Contributions
* Issues, pull requests and all contributions are welcomed!

## About

Author: Hector Zarate.

