#!/bin/bash

DATA=$(date +"%d-%m-%Y")

echo "Salvando configuracoes em $DATA" | tee backup_conf-$DATA


echo "Salvando configuracoes globais" | tee -a backup_conf-$DATA

zmprov gacf > conf_global-$DATA.txt

echo "Salvando configuracoes dos servidores Zimbra" | tee -a backup_conf-$DATA

for servidor in `zmprov gas`; do
echo "- Salvando conf. do servidor $servidor" | tee -a backup_conf-$DATA
zmprov gs $servidor > conf_$servidor-$DATA.txt
done

echo "Salvando configuracoes das classes de servico" | tee -a backup_conf-$DATA

for classe in `zmprov gac`; do
echo "- Salvando conf. da COS $classe" | tee -a backup_conf-$DATA
zmprov gc $classe > conf_cos-$classe-$DATA.txt
done
