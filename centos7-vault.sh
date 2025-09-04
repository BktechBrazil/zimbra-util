#!/bin/bash

# Backup dos repositórios antes
mkdir -p /etc/yum.repos.d/backup
cp -av /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup/

# Comentar linhas de mirrorlist
sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-*.repo

# Alterar baseurl para usar o vault 7.9.2009
sed -i 's|^#baseurl=http://mirror.centos.org/centos/\$releasever|baseurl=http://vault.centos.org/7.9.2009|g' /etc/yum.repos.d/CentOS-*.repo

# Caso haja baseurl antigo sem comentário (por exemplo, se já foi editado antes)
sed -i 's|^baseurl=http://mirror.centos.org/centos/\$releasever|baseurl=http://vault.centos.org/7.9.2009|g' /etc/yum.repos.d/CentOS-*.repo
