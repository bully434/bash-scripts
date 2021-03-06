#!/bin/bash
input=$1
if [ "$input" == "-h" ]||[ "$input" == "--help" ]; then 
	echo -e "\\e[1;33mNAME\\e[0m"
	echo  "	Configger - Script, that convert measurement units"
	echo
	echo -e "\\e[1;33mSYNOPSIS\\e[0m"
	echo -e "	\\e[1;33mconfig\\e[0m [File] "
	echo
	echo -e "\\e[1;33mDESCRIPTION\\e[0m"
	echo -e "	Simple script, that can help you with converting units."
	echo
	echo -e "\\e[1;33mEXAMPLE\\e[0m"
	echo -e "	\\e[1;33m./config.sh\\e[0m *.txt"
	echo
	exit 1
elif [ -z "$input" ]; then
echo "Wrong input. Check -h"
exit 1
else
while read -r line; do
IFS="="
out=0
declare -A time=( 
 [s]=1  [min]=1  [h]=1  [d]=1
)
declare -A weight=( 
 [mg]=1  [g]=1  [kg]=1  [t]=1
)
declare -A distance=( 
 [mm]=1  [sm]=1  [dm]=1  [m]=1  [km]=1
)
docalc=0
calc=""
set $line;
name=$1
result=$2
first=""
quantity=0
IFS=" "
for value in $result
do
if [ "$value" == "-" ]||[ "$value" == "+" ]||[ "$value" == "*" ]; then
	if [ -z $first ]; then
	first=$forcalc
	fi
	operand=$value
	docalc=1
else
	unit=${value##*[0-9]}
	numvalue=$(printf '%s\n' "${value//$unit/}")
	if [[ -n "${time[$unit]}" ]]; then
		if [ $quantity == 0 ]; then
			quantity=1
		elif [ $quantity != 1 ]; then
			echo "Wrong input. We don't compare different units."
			exit 1
		fi
	fi
	if [[ -n "${weight[$unit]}" ]]; then
		if [ $quantity == 0 ]; then
			quantity=2
		elif [ $quantity != 2 ]; then
			echo "Wrong input. We don't compare different units."
			exit 1
		fi
	fi
	if [[ -n "${distance[$unit]}" ]]; then
		if [ $quantity == 0 ]; then
			quantity=3
		elif [ $quantity != 3 ]; then
			echo "Wrong input. We don't compare different units."
			exit 1
		fi
	fi
		
	if [ "$unit" == "min" ]; then
		numvalue=$((numvalue * 60))
		if [ $docalc == 0 ]; then
		value=$(echo "$out+$numvalue" |bc);
		else
		value=$numvalue
		fi
		printres="${value}"
	fi
	if [ "$unit" == "s" ]; then
		if [ $docalc == 0 ]; then
		value=$(echo "$out+$numvalue" |bc);
		else
		value=$numvalue
		fi
		printres="${value}"
	fi
	if [ "$unit" == "h" ]; then
		numvalue=$((numvalue * 3600));
		if [ $docalc == 0 ]; then
		value=$(echo "$out+$numvalue" |bc);
		else
		value=$numvalue
		fi
		printres="${value}"
	fi
	if [ "$unit" == "d" ]; then
		numvalue=$((numvalue * 86400));
		if [ $docalc == 0 ]; then
		value=$(echo "$out+$numvalue" |bc);
		else
		value=$numvalue
		fi
		printres="${value}"
	fi
	if [ "$unit" == "mm" ]; then
		numvalue=$(echo "scale=7;${numvalue}/1000" |bc);
		if [ $docalc == 0 ]; then
		value=$(echo "scale=7;$out+$numvalue" |bc);
		else
		value=$numvalue
		fi
		printres="${value}"
	fi
	if [ "$unit" == "sm" ]; then
		numvalue=$(echo "scale=7;${numvalue}/100" |bc);
		if [ $docalc == 0 ]; then
		value=$(echo "scale=7;$out+$numvalue" |bc);
		else
		value=$numvalue
		fi
		printres="${value}"
	fi
	if [ "$unit" == "dm" ]; then
		numvalue=$(echo "scale=7;${numvalue}/10" |bc);
		if [ $docalc == 0 ]; then
		value=$(echo "scale=7;$out+$numvalue" |bc);
		else
		value=$numvalue
		fi
		printres="${value}"
	fi
	if [ "$unit" == "km" ]; then
		numvalue=$(echo "scale=7;${numvalue}*1000" |bc)
		if [ $docalc == 0 ]; then
		value=$(echo "scale=7;$out+$numvalue" |bc);
		else
		value=$numvalue
		fi
		printres="${value}"
	fi
	if [ "$unit" == "m" ]; then
		if [ $docalc == 0 ]; then
		value=$(echo "scale=7;$out+$numvalue" |bc);
		else
		value=$numvalue
		fi
		printres="${value}"
	fi
	if [ "$unit" == "mg" ]; then
		numvalue=$(echo "scale=7;${numvalue}/1000000" |bc);
		if [ $docalc == 0 ]; then
		value=$(echo "scale=7;$out+$numvalue" |bc);
		else
		value=$numvalue
		fi
		printres="${value}"
	fi
	if [ "$unit" == "kg" ]; then
		if [ $docalc == 0 ]; then
		value=$(echo "scale=7;$out+$numvalue" |bc);
		else
		value=$numvalue
		fi
		printres="${value}"
	fi
	if [ "$unit" == "g" ]; then
		numvalue=$(echo "scale=4;${numvalue}/1000" |bc);
		if [ $docalc == 0 ]; then
		value=$(echo "scale=4;$out+$numvalue" |bc);
		else
		value=$numvalue
		fi
		printres="${value}"
	fi
	if [ "$unit" == "t" ]; then
		numvalue=$(echo "scale=4;${numvalue}*1000" |bc)
		if [ $docalc == 0 ]; then
		value=$(echo "scale=4;$out+$numvalue" |bc);
		else
		value=$numvalue
		fi
		printres="${value}"
	fi
	out=$value
	forcalc=$value
	if [ $docalc == 1 ]; then
	calc=$(echo "$first$operand$forcalc" |bc);
	first=$calc
	printres="${calc}"
	docalc=0
	fi
fi
done
echo -e "$name=$printres"
done < "$input"
fi
