#!/bin/bash
count=0

if [ -z "$1" ]; then
	way=$PATH
else
	way=$1
fi

if [ "$1" == "-h" ]||[ "$1" == "--help" ]; then
	echo -e "\\e[1;33mNAME\\e[0m"
	echo  "	clearpath - Script, that clear PATH out of unnecessary directories"
	echo
	echo -e "\\e[1;33mSYNOPSIS\\e[0m"
	echo -e "	\\e[1;33mclearpath\\e[0m [Directory] "
	echo
	echo -e "\\e[1;33mDESCRIPTION\\e[0m"
	echo -e "	Simple script, that can help you with clearing PATH."
	echo
	echo -e "\\e[1;33mEXAMPLE\\e[0m"
	echo -e "	\\e[1;33m./clearpath.sh\\e[0m /bin:/usr/games:/usr/bin"
	echo
	exit 1

else
#echo $way
IFS=":" read -r -a array <<< "$way"
sort=$(for i in "${array[@]}"; do echo "$i"; done | sort -u)
IFS=$'\n'
for input in $sort
do
	for file in $input/*
	do
		if [ -x "$file" ]&&[ -f "$file" ]&&[ "${file:0:1}" == '/' ]; then
		count=$((count+1))
		fi
	done
	if ! [ $count == 0 ]; then
		if [ -z "$out" ]; then
			out=$input
			count=0
		else
			out=$out:$input
			count=0
		fi
	fi
done
echo "$out"
fi
