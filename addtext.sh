 #!/bin/bash
dir=$1
output=$2
text=$3
package=`dpkg -s imagemagick 2>/dev/null | grep "Status"`

if [ -z $1 ]; then
	echo Bad Usage. try -h
	exit 1
fi

while true; do
if [ -z $1 ]; then
	break
elif [ $1 = "--indir" ] || [ $1 = "-i" ]; then
	dir=$2
	shift 2
elif [ $1 = "--outdir" ] || [ $1 = "-o" ]; then
	output=$2
	shift 2
elif [ $1 = "--text" ] || [ $1 = "-t" ]; then
	text=$2
	shift 2
elif [ $1 = "--size" ] || [ $1 = "-s" ]; then
	size=$2
	shift 2
elif [ $1 = "--font" ] || [ $1 = "-f" ]; then
	font=$2
	shift 2

elif [ "$1" == "-h" ]; then
	echo -e "\e[1;33mNAME\e[0m"
	echo  "	addtext - Script, that adds annotations onto your pictures"
	echo
	echo -e "\e[1;33mSYNOPSIS\e[0m"
	echo -e "	\e[1;33maddtext\e[0m [InputDirectory] [OutputDirectory] [Text] Font FontSize "
	echo
	echo -e "\e[1;33mDESCRIPTION\e[0m"
	echo -e "	Simple script, that can help you with adding different signs on your pictures."
	echo
	echo -e "	\e[1;33m--indir, -i\e[0m" 
	echo "		 input directory for nonmodified photos"
	echo -e "	\e[1;33m--outdir, -o\e[0m" 
	echo "		 output directory for modified photos"
	echo -e "	\e[1;33m--text, -t\e[0m" 
	echo "		 Text, that you want to add"
	echo -e "	\e[1;33m--font, -f\e[0m"
	echo "		 Font of text"
	echo -e "	\e[1;33m--size, -s\e[0m" 
	echo "		 Size of font"
	echo
	exit 1
fi
done

if [ -z "$size" ]; then
	size=50
elif [ "$size" -ge "100" ]; then
	echo Font size is too large. Would it be possible to reduce it?
	exit 1
fi

if [ -z "$font" ]; then
	font="Courier"
fi


if ! [ -n "$package" ]; then
	echo "Imagemagick isn't installed. We recommend to install it, if you want to use our script"
	exit 1
fi


if ! [ -d $output ]; then
	echo Creating the Folder
	mkdir $output
fi

files=$(find $dir -type f \( -name '*.jpg' \) -exec basename '{}' \;)
for file in $files
do
convert "$dir/$file" -font $font -fill white -pointsize $size -gravity SouthEast -annotate 0 $text "$output/$file"
if [ $? -ne 0 ]; then
echo Error
exit 1
else
echo "The job is done."
fi
done
