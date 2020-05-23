#!/bin/sh

docker run --rm  -u root \
  --network=brokerage_AAA-brokerage-network \
  --name=keycloak_exporter \
  -v $(pwd)/keycloak-export:/tmp/keycloak-export \
  -e DB_VENDOR=POSTGRES \
  -e DB_ADDR=postgres \
  -e DB_PORT=5432 \
  -e DB_DATABASE=keycloak \
  -e DB_USER=keycloak \
  -e DB_PASSWORD=password \
  jboss/keycloak \
  -Dkeycloak.migration.action=export \
  -Dkeycloak.migration.provider=dir\
  -Dkeycloak.migration.dir=/tmp/keycloak-export \
  -Dkeycloak.migration.usersExportStrategy=SAME_FILE

exit
  -Dkeycloak.migration.action=export \
  -Dkeycloak.migration.provider=singleFile \
  -Dkeycloak.migration.file=/tmp/keycloak-export/all-realm.json \
  -Dkeycloak.migration.usersExportStrategy=SAME_FILE
