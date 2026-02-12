#!/bin/bash
set -e
#Iniciar servicio NGINX en ubuntu
echo "Starting Nginx..."
sudo service nginx start
sudo service zabbix-agent start
