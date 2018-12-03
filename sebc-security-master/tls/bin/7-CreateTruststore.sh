#!/bin/sh

source ./clustervars

JAVA_SEC_LIB=$JAVA_HOME/jre/lib/security/
PATH=$JAVA_HOME/bin:$PATH

cp $JAVA_SEC_LIB/cacerts ./jssecacerts

keytool -import -trustcacerts -keystore jssecacerts -alias rootca -storepass changeit -file rootca.pem -noprompt
keytool -importcert -keystore truststore.jks -alias rootca -file rootca.pem -storepass ${PASSWORD} -noprompt
