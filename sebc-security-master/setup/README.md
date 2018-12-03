# Setting up SSSD and LDAP

SSSD and LDAP are required to ensure that users and groups in a centralized LDAP/AD are visible to ALL hosts in a cluster. To this end, we will need to configure both. Please note that in enterprise clients, the use of SSSD and/or OpenLDAP is not recommended. Instead, more enterprise grade solutions such as Centrify and Active Directory are recommended. For this bootcamp, however, we will use open-source equivalents that are available on Linux.

<li>Start by setting up <a href="ldap">LDAP</a></li>
<li>Then, continue with <a href="sssd">SSSD</a></li>

<br/>

PS: We have tested this in CentOS 7.x so if you are on a different OS, your instructions to setup LDAP and SSSD may be different. Consult your OS documentation online.
