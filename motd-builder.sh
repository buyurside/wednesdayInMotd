#!/usr/local/bin/bash
#!/bin/bash

if [ "$EUID" -ne 0 ];
then
	echo "This script requires root to modify /etc/motd"
	exit
fi

# tnx
# https://stackoverflow.com/questions/630372/determine-the-path-of-the-executing-bash-script
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

path2banner="/etc/motd"
myDudes="Wed"


if [ ! -e $MY_PATH/motdSrcs/essential ]; then
	cp /etc/motd $MY_PATH/motdSrcs/essential
fi
	

while [ true ];
do
	today="$( cut -d' ' -f1 <<< "$(date)" )"
	if [ "$myDudes" == "$today" ]; then
		cat $MY_PATH/motdSrcs/wednes.day $MY_PATH/motdSrcs/essential > $path2banner
	else
		cat $MY_PATH/motdSrcs/essential > $path2banner
	fi

	sleep 60
done
