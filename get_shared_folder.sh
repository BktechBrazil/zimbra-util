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
#zmprov ga gleber@capitallinux.com.br | grep -i zimbraMailAlias | cut -d" " -f2
while read USERS
do
    ALIAS=`zmprov ga $USERS | grep -i zimbraMailAlias | cut -d" " -f2 | tr '\n' ' ' `
	echo "Account: $USERS | Alias: $ALIAS" >> /tmp/collect_zimbra_shared_folders.txt
	for USER in $USERS
	do
		echo
		zmmailbox -z -m $USER gaf > /tmp/shares$$
		grep : /tmp/shares$$ | cut -c 43-
		zmmailbox -z -m $USER gaf | egrep -v ':|Count|----------' | cut -c 43- > /tmp/shares$$
		cat /tmp/shares$$ |while read FOLDER 
		do
			TESTE=`zmmailbox -z -m $USER gfg "$FOLDER" | sed -n 3p`
			if [[ $TESTE != "" ]]; then
				echo Grants for $USER: $FOLDER:
# 				ALIAS=`zmprov ga $USER | grep -i zimbraMailAlias | cut -d" " -f2				>> /tmp/collect_zimbra_shared_folders.txt`
				zmmailbox -z -m $USER gfg "$FOLDER" >> /tmp/collect_zimbra_shared_folders.txt
			fi
		done
			echo
		done
done < $USER_FILE
rm -f /tmp/shares$$
rm -f $USER_FILE
