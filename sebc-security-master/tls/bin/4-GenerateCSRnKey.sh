#!/bin/sh

source ./clustervars

CN=$1

openssl req -new -newkey rsa:2048 -sha256 -keyout ${CN}.key -out ${CN}.csr -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGNAME}/OU=${ORGUNIT}/CN=${CN}" -passin pass:${PASSWORD} -passout pass:${PASSWORD}
