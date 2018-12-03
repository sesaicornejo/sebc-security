#!/bin/sh

source ./clustervars

PATH=$JAVA_HOME/bin:$PATH

CN=$1

openssl pkcs12 -export -inkey ${CN}.key -in ${CN}.pem -passin pass:${PASSWORD} -out ${CN}.p12 -passout pass:${PASSWORD} -name ${CN}

keytool -importkeystore -alias ${CN} -srckeystore ${CN}.p12 -srcstoretype PKCS12 -srcstorepass ${PASSWORD} -destkeystore ${CN}.jks -deststoretype JKS -deststorepass ${PASSWORD}
