#!/usr/bin/env bash

base_opt_path='/opt/docker/clair'
CLAIR="${base_opt_path}/clair_config"
QUAY="${base_opt_path}/quay"
export QUAY CLAIR
docker run -d -e POSTGRES_PASSWORD="PASS" --name clair-db --net clair postgres:9.6
sleep 5
docker run --net clair -d -v "${CLAIR}":/config --name clair quay.io/coreos/clair:latest -config=/config/config.yaml

docker container ls

sudo setfacl -m u:26:-wx $QUAY/postgres
docker run -d --rm --name quay-db --net clair -e POSTGRES_USER=quay -e POSTGRES_PASSWORD=quay -e POSTGRES_DB=quay -v $QUAY/postgres:/var/lib/postgresql/data postgres:10.12
sleep 5
docker exec -it quay-db /bin/bash -c 'echo "CREATE EXTENSION IF NOT EXISTS pg_trgm" | psql -d quay -U quay'
docker inspect -f "{{.NetworkSettings.IPAddress}}" postgresql

docker run -d --rm --name quay-redis --net clair redis:5.0.7 --requirepass strongpassword

docker inspect -f "{{.NetworkSettings.IPAddress}}" redis
docker run --rm -it -d --name quay-config --net clair -p 8443:8443 quay.io/projectquay/quay config secret

docker logs -f quay-config
docker rm -f quay-config

curl -kfsSL 'https://127.0.0.1:8443/api/v1/configapp/tarconfig' -H 'Accept: application/json, text/plain, */*'--compressed -H 'Authorization: Basic cXVheWNvbmZpZzpzZWNyZXQ=' | sudo bsdtar -C "${QUAY}/config/" -xf -

# quayconfig/secret
## users
# un: quay
# email: 
# pw: password

docker run -p 8080:8080 --net clair --name=quay --privileged=true -v $QUAY/config:/conf/stack -v $QUAY/storage:/datastorage -d quay.io/projectquay/quay:latest
