#!/bin/bash
input=$1
if [ -z "$input" ]; then
input=$(pwd)
fi
if [ "$1" == "-h" ]||[ "$1" == "--help" ]; then
	echo -e "\\e[1;33mNAME\\e[0m"
	echo  "	shardCollect - Script, that delete unused directories"
	echo
	echo -e "\\e[1;33mSYNOPSIS\\e[0m"
	echo -e "	\\e[1;33mshardCollect.sh\\e[0m [Directory] "
	echo
	echo -e "\\e[1;33mDESCRIPTION\\e[0m"
	echo -e "	Simple script, that help you with erasing unused directories"
	echo
	echo -e "\\e[1;33mEXAMPLE\\e[0m"
	echo -e "	\\e[1;33m./shardCollect.sh\\e[0m ~/Desktop"
	echo -e "	\\e[1;33m./shardCollect.sh\\e[0m"
	echo
	exit 1

else
read -ra array <<< "$(echo $(find "$input" -mindepth 1 -type d))"
read -ra lsofList <<< "$(echo $(lsof +D "$input" |  awk '$9 ~ /^ *\// {print $9}'))"
count=0
for i in "${array[@]}"
do
	for elem in "${lsofList[@]}"
	do
		if [ "$i" == "$(dirname "$elem")" ]; then
			count=1
		fi
	done
	if [ "$count" == "0" ]; then
    	echo "$i";
    	fi
	count=0
done
fi
