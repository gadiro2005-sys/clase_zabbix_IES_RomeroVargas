#!/bin/bash
set -e
#Iniciar servicio NGINX en ubuntu
echo "Starting Nginx..."
sudo service nginx start
sudo service zabbix-agent start

echo "Services started. Keeping container alive..."

# This follows the logs forever, keeping the script from exiting
tail -f /var/log/nginx/access.log