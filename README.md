# IES_ROMERO_DESPLIEGUE2

# 💻 Práctica despliegue seguro de aplicaciones con github actions
# IES Romero Vargas - Jerez de la Frontera (Cádiz)


## 📌 Descripción clase 1
Esta práctica tiene como objetivo:
- Comprender el concepto de despliegue seguro de aplicaciones simulando servidores con docker
- Comprobar el flujo de github actions en el despliegue de cambios en todos los contenedores docker

---

## 🛠️ Tecnologías utilizadas
- Docker
- HTML, CSS
- Zabbix
---

## ✅ Instalación y configuración

### 1. Arrancar máquina docker

Clonar repositorio

```
git clone https://github.com/gadiro2005-sys/clase_zabbix_IES_RomeroVargas.git
cd clase_zabbix_IES_RomeroVargas
```

Arrancamos el contendor docker para la práctica

```
cd docker
docker compose up -d
o de otra forma
docker-compose up -d
```
```
docker ps -a
docker exec -it ubuntu22_server /bin/bash
./githubaction.sh
```

Abrir el navegador con la siguiente dirección url:
- [ ] [Localhost](http://localhost:8006) 
Veremos la página index del servidor web NGINX


## License
GNU - For open source projects.

