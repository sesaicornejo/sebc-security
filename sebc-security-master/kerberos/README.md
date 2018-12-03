# Setting up Kerberos

Now you will setup MIT Kerberos. When using Active Directory, a Kerberos system will be provided. However, in lieu of an Active Directory, you will use MIT Kerberos. First start by defining your KERBEROS_SERVER on the same host as your LDAP_SERVER to make things easier to diagnose. Once you do that, you will need to install the Kerberos server on it as well as the Kerberos client on all hosts.

Please refer to the <a href="https://en.wikipedia.org/wiki/Kerberos_(protocol)">following documentation</a> to learn more about Kerberos. Then refer to <a href="https://www.centos.org/docs/5/html/Deployment_Guide-en-US/ch-kerberos.html">here</a> to learn how to create your own Kerberos server. It is important to understand that for Kerberos to work correctly, all hostnames must be fully qualified using lowercase characters (e.g., host-01.mydomain.com vs. HOST-01.MYDOMAIN.COM) and reverse DNS lookups must map IP addresses to the same hostname.

Some Kerberos concepts worth noting:

- A Kerberos Realm is the equivalent to a corporate domain. When using MIT Kerberos, your Kerberos Realm can be anything you want and should be all UPPERCASE!
- Users are called User Principals and services are called Service Principals. 
- User principals take the form <username>@<REALM> which is referred to as User Principal Name or UPN for short
- Service principals on the other hand take the form <servicename>/<hostname>@<REALM> which is referred to as Service Principal Name or SPN for short
- User principals tend to be interactive users and authenticate with Kerberos using a password
- Service principals tend not to be interactive and therefore can't be prompted for passwords so instead often use what are called 'keytabs'
- Keytabs are files which contain an encrypted 'shared secret' stored in the Kerberos server AND the host where the service runs
- Keytab files must be fully protected with proper permissions (e.g., owned by the service user with restrictive permissions like 'chmod 600')

When using Active Directory, user and service principals are created in the context of the corresponding Active Directory user or service. Therefore, users can use their AD credentials (username and password) to authenticate with a cluster (provided the cluster is Kerberized against the same corporate domain or REALM). However, when using OpenLDAP and MIT Kerberos, these act as two distinct solutions each storing user and password information in their own datastores.

To enable Kerberos authentication for a cluster, a designated Kerberos admin user must be created (whether it is AD or MIT Kerberos). When Kerberizing a cluster against AD, an organizational unit must be supplied as well by the AD admin where the Kerberos admin user is allowed to create and delete SPNs. Please note that when using AD, Cloudera Manager will use the admin user to create service names along with corresponding SPNs for each role run on each host, but the <servicename> component will be randomized for additional security (a prefix can be configured for better identification or search of the resources created). When using MIT Kerberos, the SPNs will be created using their expected names. Keytabs for each role will be automatically generated and transfered over the network to the corresponding host.

NOTE: Due to the fact that keytabs contain sensitive information and are transferred over the network, the safest way to configure Kerberos is to enable <a href="../tls">Transport Layer Security (TLS)</a> first before enabling Kerberos. This ensures that all keytabs generated are transferred over encrypted. For this camp, we will not be applying this recommendation.

Your task now is to configure MIT Kerberos on your KERBEROS_SERVER for the corresponding KERBEROS_REALM, configure a Kerberos administrator which can be used by Cloudera Manager to create SPNs, and add the following UPNs:

<li>admin</li>
<li>user1</li>
<li>user2</li>
<li>user3</li>
<li>user4</li>

<br/>

Assign the password "passw0rd" to all them. Then proceed to install and configure the Kerberos client on all hosts and make sure you can authenticate each user from each host using the following command:

```
kinit <username>@<KERBEROS_REALM>
```

Once this is working, review <a href="https://www.cloudera.com/documentation/enterprise/5-13-x/topics/cm_sg_intro_kerb.html">here</a> for how to enable Kerberos in Cloudera. Upload your configuration files and results from your test in the <a href="config">config</a> directory.
