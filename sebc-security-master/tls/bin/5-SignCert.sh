#!/bin/sh

source ./clustervars

CN=$1

cp ca/intermediate/openssl.cnf .
cat >> openssl.cnf << EOF
[ server_cert ]
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth, clientAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${CN}
EOF

# Create signed cert with intermediate CA and server_cert extensions (which include serverAuth and clientAuth for multiple use and TLS3)
openssl ca -config openssl.cnf -extensions server_cert -days 365 -notext -md sha256 -in ${CN}.csr -out ${CN}.pem -batch

cat rootca.pem intermediateca.pem > cacerts

chmod 400 ${CN}.key
chmod 444 ${CN}.pem
