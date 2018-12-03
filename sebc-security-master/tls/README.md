# Setting up TLS

Now you will setup Transport Layer Security (TLS). TLS ensures that all network communications between hosts are encrypted. In order to enable TLS, signed certificates must be made available meeting the following requirements:

<li>Common Name of the certificate must match that of its corresponding hostname</li>
<li>Key Usage attributes set for 'digital signature' and 'key encipherment'</li>
<li>Extended Key Usage attributes set for both 'server' and 'client' authentication</li>
<li>Subject Alternate Name set to any aliases used to identify the host (e.g., load balancer DNS)</li>

<br/>

Read over the <a href="https://www.cloudera.com/documentation/enterprise/5-13-x/topics/how_to_configure_cm_tls.html">following documentation</a> to learn how to enable TLS for Cloudera Manager and its agents.

Your goal on this bootcamp is to enable TLS for Cloudera Manager as well as Level 1, Level 2, and Level 3 encryption for Cloudera Manager and its agents. You have been provided with scripts <a href="bin">here</a> to help you simulate the certificate generation process. The scripts will produce signed certificates from your own Certificate Authority (CA). The CA will consist of a root CA with a self-signed certificate and an intermediate CA with a certificate signed by the root CA. Your host certificates will be signed by the intermediate CA.

Upload your <a href="config/cloudera-scm-agent.ini">Cloudera Agent .ini file</a> as well as a <a href="config/screenshot.png">screenshot</a> of Cloudera Manager showing all services are green. The screenshot must also show that you are accessing Cloudera Manager using https on port 7183 vs. http on port 7180.
