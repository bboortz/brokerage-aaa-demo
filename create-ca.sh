#!/bin/sh

cd ca

# generate ca
cfssl gencert -initca ca-csr.json | cfssljson -bare ca

# generate server certificate for debug
cd debug
cp ../ca.pem .
cfssl gencert \
	-ca=../ca.pem \
	-ca-key=../ca-key.pem \
	-config=../ca-config.json \
	-profile=web-servers \
	debug-csr.json | cfssljson -bare debug
openssl verify -CAfile ../ca.pem debug.pem
cd ..

# generate server certificate for the app
cd app
cp ../ca.pem .
cfssl gencert \
	-ca=../ca.pem \
	-ca-key=../ca-key.pem \
	-config=../ca-config.json \
	-profile=web-servers \
	app-csr.json | cfssljson -bare app
openssl verify -CAfile ../ca.pem app.pem
cd ..

# generate server certificate for keycloak
cd keycloak
cp ../ca.pem .
cfssl gencert \
	-ca=../ca.pem \
	-ca-key=../ca-key.pem \
	-config=../ca-config.json \
	-profile=web-servers \
	keycloak-csr.json | cfssljson -bare keycloak
openssl verify -CAfile ../ca.pem keycloak.pem
cp keycloak-key.pem tls.key
cp keycloak.pem tls.crt
cd ..
