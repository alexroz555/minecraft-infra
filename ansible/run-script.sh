#!/bin/bash

INSTANCE_IP=$(aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=minecraft-server" \
  --query "Reservations[*].Instances[*].PublicIpAddress" \
  --output text)

echo "[minecraft]" > hosts.ini
echo "$INSTANCE_IP ansible_user=ec2-user ansible_ssh_private_key_file=~"wordpress.pem >> hosts.ini

ansible-playbook -i hosts.ini playbook.yml
