#!/bin/bash
################################# get_shared_folder.sh ###########################
# Version : 1.0                                                                  #
# Date : 01 Jul 2019                                                             #
# Author : Gleber Ribeiro Leite (gleber@bktech.com.br)                           #
# Contributor(s):                                                                #
##################################################################################
DATE=`date '+%d-%m-%Y'`
USER_FILE="/tmp/users.txt"
echo "" > /tmp/collect_zimbra_shared_folders.txt
#clear
echo "$DATE" >> /tmp/collect_zimbra_shared_folders.txt
echo "" >> /tmp/collect_zimbra_shared_folders.txt
echo Getting Folder Share Grants... >> /tmp/collect_zimbra_shared_folders.txt
zmprov -l gaa > $USER_FILE
while read USERS
do
	echo Account: $USERS >> /tmp/collect_zimbra_shared_folders.txt
	for USER in $USERS
	do
		echo
		zmmailbox -z -m $USER gaf > /tmp/shares$$
#		echo Mailbox folders for $USER
#		cat /tmp/shares$$
#		echo ; echo Accepted shared folders from others:
		grep : /tmp/shares$$ | cut -c 43-
#		echo
		zmmailbox -z -m $USER gaf | egrep -v ':|Count|----------' | cut -c 43- > /tmp/shares$$
		cat /tmp/shares$$ |while read FOLDER 
		do
			TESTE=`zmmailbox -z -m $USER gfg "$FOLDER" | sed -n 3p`
			if [[ $TESTE != "" ]]; then
				echo Grants for $USER: $FOLDER:
				zmmailbox -z -m $USER gfg "$FOLDER" >> /tmp/collect_zimbra_shared_folders.txt
#				echo
			fi
		done
			echo
		done
done < $USER_FILE
rm -f /tmp/shares$$
rm -f $USER_FILE
