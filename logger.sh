#!/bin/bash
input=$1

if [ "$input" == "-h" ]||[ "$1" == "--help" ]; then
	echo -e "\\e[1;33mNAME\\e[0m"
	echo  "	logHelper - Script, that help you to determine the most frequent request"
	echo
	echo -e "\\e[1;33mSYNOPSIS\\e[0m"
	echo -e "	\\e[1;33mlog\\e[0m [File] "
	echo
	echo -e "\\e[1;33mDESCRIPTION\\e[0m"
	echo -e "	Simple script, that can help you with difficult logs."
	echo
	echo -e "\\e[1;33mEXAMPLE\\e[0m"
	echo -e "	\\e[1;33m./log.sh\\e[0m log.txt"
	echo
	exit 1
else
	sort "$input" | cut -f4 -d"|" | sort | uniq -c | sort -nr | head -n1
fi
