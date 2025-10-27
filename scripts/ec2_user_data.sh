#!/bin/bash
# Exemplo de user-data para Amazon Linux 2 que instala nginx, formata e monta EBS em /data

set -euo pipefail

# Atualizar e instalar
yum update -y
yum install -y nginx

# Device esperado (ajuste conforme necessário)
DEVICE="/dev/xvdf"
MOUNTPOINT="/data"

# Aguarda dispositivo aparecer (timeout simples)
for i in {1..10}; do
  if [ -b "$DEVICE" ]; then
    break
  fi
  sleep 2
done

# Se não existir sistema de arquivos, criar e montar
if [ -b "$DEVICE" ]; then
  if ! blkid "$DEVICE" >/dev/null 2>&1; then
    mkfs -t ext4 "$DEVICE"
  fi

  mkdir -p "$MOUNTPOINT"
  mount "$DEVICE" "$MOUNTPOINT"

  # Adicionar ao fstab por UUID
  UUID=$(blkid -s UUID -o value "$DEVICE")
  if ! grep -q "$UUID" /etc/fstab; then
    echo "UUID=$UUID  $MOUNTPOINT  ext4  defaults,nofail  0  2" >> /etc/fstab
  fi
fi

# Start nginx
systemctl enable nginx
systemctl start nginx

# Cria página inicial
echo "<h1>EC2 with EBS - $(hostname)</h1>" > /usr/share/nginx/html/index.html