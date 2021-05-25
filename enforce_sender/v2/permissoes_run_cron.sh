#!/bin/bash

/tmp/gerar_perms.sh
/tmp/gerar_perms_listas.sh

cat resultado_sendas.txt resultado_sendas_DistList.txt > /tmp/resultado.txt
