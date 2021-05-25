#!/bin/bash

SCRIPT_DIR="/tmp"
SENDER_ENFORCER_FILE="/opt/zimbra/conf/slm-exceptions-db"

$SCRIPT_DIR/gerar_perms.sh
$SCRIPT_DIR/gerar_perms_listas.sh

#ARQUIVOS TEMPORARIOS SEMPRE SALVOS NO /TMP
cat /tmp/resultado_sendas.txt /tmp/resultado_sendas_DistList.txt > $SENDER_ENFORCER_FILE
