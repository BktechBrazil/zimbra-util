#!/bin/bash

ARQUIVO="contas.txt"

IFS=$'\n'

for CONTA in `cat $ARQUIVO`
do
  EMAIL=`grep "$CONTA" todas_contas_email.csv | awk -F , '{print $2}'`
  SURNAME=`grep "$CONTA" todas_contas_email.csv | awk -F , '{print $5}'`
  GIVENNAME=`grep "$CONTA" todas_contas_email.csv | awk -F , '{print $4}'`
  DISPLAYNAME=`grep "$CONTA" todas_contas_email.csv | awk -F , '{print $6}'`
  echo "ca \"$EMAIL\" \"\" sn \"$SURNAME\" givenName \"$GIVENNAME\" displayName \"$DISPLAYNAME\""
done