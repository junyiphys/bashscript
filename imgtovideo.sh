#!/bin/bash
dir_main=$(pwd) #using local path

#Test the dictionary. Exists, clear it; if not exists, skip it.
DictionaryExists(){
	if [ -d $1 ]; then
	    	echo "Dictionary exists. Continue."
	else
	    echo "Directory $1 does not exists. Close Program."
	    exit
	fi
}

DictionaryExists $dir_main



# Batch for showing the 
for name in $dir_main/*/; do
	files_name=($name*.png)
	filename=$(basename -- "$files_name")
	filenum="${filename//[!0-9]}"
	
	# Add the time stamp on the image 
   mogrify -font Liberation-Sans -fill white -undercolor '#00000080' \
-pointsize 26 -gravity NorthEast -annotate +10+10 %t "${name%}*.png"

	# Merge the all images as a single video
   ffmpeg -framerate 10 -start_number $filenum -i ${name}f%d.png -c:v libx264 -crf 20 -pix_fmt yuv420p "$(dirname $name)/$(basename $name).mp4" -y
done 



