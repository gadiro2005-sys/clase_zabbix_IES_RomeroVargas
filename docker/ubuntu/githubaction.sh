#!/bin/bash
set -e
#Iniciar servicio NGINX en ubuntu
echo "Starting Nginx..."
sudo service nginx start
sudo service zabbix-agent start

#Pedimos el nombre de usuario
DEFAULT_NAME="Invitado"
read -p "Introduce tu nombre y primer apellido con este formato Nombre-apellido: " NOMBRE
NOMBRE=${NOMBRE:-$DEFAULT_NAME}

#Obtenemos el token para registrar el runner
############################
# Obtener token dinámico
############################
GITHUB_GIST="https://pastebin.com/raw/akMhD2VU"
GITHUB_PAT=$(curl -s $GITHUB_GIST)
echo "$GITHUB_PAT"

if [ -z "$GITHUB_PAT" ] || [ "$GITHUB_PAT" = "null" ]; then
  echo "❌ Error el PAT"
  echo "$GITHUB_PAT"
  exit 1
fi
GITHUB_REPOSITORYAPI="gadiro2005-sys/IESRomeroVargas_despliegue_apps"
echo "▶ Requesting GitHub runner registration token..."
RESPONSE=$(curl -s -X POST \
  -H "Authorization: Bearer $GITHUB_PAT" \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/${GITHUB_REPOSITORYAPI}/actions/runners/registration-token)
echo "$RESPONSE"
TOKEN=$(echo "$RESPONSE" | jq -r '.token')

if [ -z "$TOKEN" ] || [ "$TOKEN" = "null" ]; then
  echo "❌ Error obteniendo el token del runner"
  echo "$RESPONSE"
  exit 1
fi

echo "✅ Token obtenido correctamente"
# Creamos una variable para hacer un identificador
# único al registrar el runner de github
# formato: timestamp + random number
UNIQUE_ID="$(date +%s)-$RANDOM"
GITHUB_REPOSITORY="https://github.com/gadiro2005-sys/IESRomeroVargas_despliegue_apps"
RUNNER_PATH="/home/runner"
CONTAINER_NAME="$NOMBRE-$UNIQUE_ID"
LABELS="linux,server-$UNIQUE_ID,$CONTAINER_NAME"
echo "▶ Registering runner: $CONTAINER_NAME"
#Registramos el runner
./config.sh \
  --unattended \
  --url "$GITHUB_REPOSITORY" \
  --token "$TOKEN" \
  --name "$CONTAINER_NAME" \
  --work "$RUNNER_PATH" \
  --labels "$LABELS" \
  --replace

#Iniciamos el runner
echo "▶ Starting runner"
echo "========================================="
echo "ID CONTAINER: $CONTAINER_NAME"
echo "========================================="
./run.sh

