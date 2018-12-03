# Certificate Scripts

The following scripts are provided to help simulate the certificate generation process. However, we do not have a Certificate Authority to issue signed certificates. In its absence, we will create our own root and intermediate CAs using the following scripts (but first make sure your clustervars file is edited with your cluster details):

```
./2-CreateRootCA.sh
./3-CreateIntermediateCA.sh
```

Once you have your root and intermediate CAs created (which is not something you would be required to do in real environment), you need to generate your Certificate Signing Requests (CSRs) along with its corresponding Private Key FOR EACH HOST. Remember your certificates have pre-requisites that must be met so inspect the contents of the following script before running it too. The required attributes are included in the certificates during the CSR process. To get the CSRs and Private Keys created:

```
./4-GenerateCSRnKey.sh <FQDN>
```

This will create a CSR and a Private Key file named hostname.csr and hostname.key, respectively (where hostname is the actual hostname of the host for which the certificate belongs). The CSR is what you provide to your CA to issue signed certificates while keeping the private keys stored in a safe place. Since we are managing the Certificate Authority, we will emulate the signing process:

```
./5-SignCert.sh <FQDN>
```

You will now have a signed certificate named hostname.pem. To verify that the certificate and key match, ensure that the following both output the same MD5 checksum:

```
openssl x509 -modulus -in hostname.pem -noout | openssl md5
openssl rsa  -modulus -in hostname.key -noout | openssl md5
```

This process so far has create x509 (PEM) format certificates which can be used by non-Java applications. However, Java applications require a Java KeyStore (JKS) format. In Cloudera, we have a combination of Java and non-Java based components so both are required. To create the JKS format of the certificates:

```
./6-CreateKeystore.sh <FQDN>
./7-CreateTruststore.sh
```

Once the process is completed, you will require the following files:

<li><b>PEM and JKS Truststore:</b> rootca.pem, intermediateca.pem and truststore.jks</li>
<li><b>PEM and JKS Keystore:</b> hostname.pem and hostname.jks</li>
<li><b>PEM key:</b> hostname.key (the private key for JKS is included in hostname.jks)</li>

<br/>

You may inspect the contents of each certificate via the following command:

```
PEM: openssl x509 -in hostname.pem -text -noout
JKS: keytool -keystore hostname.jks -storepass password -list -v
```

Please submit the output from this command on at least one certificate and publish it <a href="output.txt">here</a>
