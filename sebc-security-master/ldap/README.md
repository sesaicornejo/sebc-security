# Setting up LDAP

Now you will setup LDAP authentication which is used for the following components:

<li>Cloudera Manager</li>
<li>Cloudera Navigator</li>
<li>HUE</li>
<li>Optional: Other components allow LDAP authentication along or in lieu of Kerberos: Impala, Hive, etc.</li>

<br/>

When configuring LDAP for Cloudera Manager, keep in mind the following concepts:

<li>LDAP URL: Takes the form ldap[s]://LDAP_SERVER:PORT where ldaps is used for secure LDAP connections</li>
<li>LDAP Bind User Distinguished Name: User allowed to search the directory for users and groups</li>
<li>LDAP Bind Password: Password for the Bind User</li>
<li>LDAP User Search Base: Tree within the directory to search for users</li>
<li>LDAP User Search Filter: Filter used to search for users</li>
<li>LDAP Group Search Base: Tree within the directory to search for groups</li>
<li>LDAP Group Search Filter: Filter used to search for groups</li>

<br/>

Please note that the use of ldaps is EXTREMELY IMPORTANT as otherwise users would be authenticated passing their credentials in clear text over the network! Anyone intercepting traffic would get immediate access to private credentials!

For this bootcamp, your job is to configure LDAP authentication ONLY for Cloudera Manager by following the documentation posted <a href="https://www.cloudera.com/documentation/enterprise/5-13-x/topics/cm_sg_external_auth.html">here</a>. Inspect your <a href="../setup/ldap">LDAP</a> configuration to fill in the values:

<li><b>LDAP URL:</b> ldap://LDAP_SERVER</li>
<li><b>LDAP Bind User Distinguished Name:</b> (this is the LDAP admin user in Distinguished Name form cn=xxx,dc=xxx,dc=xxx)</li>
<li><b>LDAP Bind User Password:</b> passw0rd</li>
<li><b>LDAP User Search Base:</b> (this is the Org Unit holding users following Distinguished Name form ou=xxx,dc=xxx,dc=xxx)</li>
<li><b>LDAP User Search Filter:</b> (uid={0})</li>
<li><b>LDAP Group Search Base:</b> (this is the Org Unit holding groups following Distinguished Name form ou=xxx,dc=xxx,dc=xxx)</li>
<li><b>LDAP Group Search Fiter:</b> (memberUid={0})</li>

<br/>

You will need to set <b>Authentication Backend Order</b> to <b>External then Database</b> (this prevents you from getting locked out if the LDAP configuration does not work) and <b>External Authentication Type</b> to <b>LDAP</b>. Also make the 'admins' group be the <b>LDAP Full Administrator Groups</b>. You will need to restart the Cloudera Manager server via the following command:

```
service cloudera-scm-server restart
```

Test your configuration by logging into Cloudera Manager using the admin:passw0rd as well as userX:passw0rd credentials. Take a screenshot and show that you are logged into Cloudera Manager as an admin user (member of the Full Administrator Group) and then also as a regular user without administrative capabilities.
