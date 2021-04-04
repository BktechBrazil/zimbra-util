#!/bin/bash
### EM DESENVOLVIMENTO ####

#FABIO S. SCHMIDT
#SCRIPT PARA OBTER RELAÇÃO DE PERMISSOES DE ENVIO - SENDAS - DE CONTAS
#E
#CRIAR ARQUIVO PARA REGRA DE ALLOW NO POSTFIX

cont1=0
cont2=0

# RELACAO DE CONTAS OBTIDAS - AJUSTE O FILTRO COMO NECESSITAR
for i in $(zmprov -l sa "(zimbraCosId=d58ae75d-2718-4066-8455-7411007e60aa)"); do

zmprov gg -t account $i | grep sendAs | grep -v "^-" | grep -v "^target" | awk '{ print $6 }' > /tmp/relacao_sendas.txt
cont1=$((cont1+1))
echo "####### $cont1 $i"
cont2=0
for j in $(cat /tmp/relacao_sendas.txt); do
cont2=$((cont2+1))
echo -n "$cont2"

#GERA O ARQUIVO QUE SERA UTILIZADO PARA AS PERMISSOES DE ENVIO
echo "$i $j" >> /tmp/resultado_sendas.txt
done
echo " "

done