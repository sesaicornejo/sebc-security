# Setting up SSSD

SSSD will be used to integrate your OS with your LDAP server and authenticate users against it. Please note that the use of SSSD is not recommended for enterprise customers. While it may work, performance of SSSD may impact your user experience.

On all hosts, perform the following steps. Make sure to update your LDAP_SERVER with the host you chose for that. Also, we will use the LDAP_SERVER as your Kerberos server. Update the KERBEROS_REALM too.

```
export LDAP_SERVER=myldapserver.sebc.org
export KERBEROS_REALM=MYSEBC.ORG
export LDAP_SEARCH_BASE=dc=sebc,dc=org

yum -y install sssd-client sssd-tools sssd oddjob-mkhomedir authconfig

authconfig --enableshadow --passalgo=sha512 --enablesssd --enablesssdauth --enablemkhomedir --updateall

echo "[sssd]
config_file_version = 2
services = nss, pam, autofs
domains = default
debug_level = 0

[nss]
filter_users = root,ldap,named,avahi,haldaemon,dbus,radiusd,news,nscd

[pam]

[domain/default]
debug_level = 0
id_provider = ldap
auth_provider = ldap
autofs_provider = ldap
chpass_provider = ldap
cache_credentials = False
entry_cache_timeout = 600
#ldap_schema = rfc2307bis
ldap_tls_reqcert = never
ldap_search_base = ${LDAP_SEARCH_BASE}
ldap_user_object_class = posixAccount
ldap_group_object_class = posixGroup
ldap_user_name = uid
ldap_user_home_directory = homeDirectory
ldap_group_member = memberUid
ldap_id_use_start_tls = False
ldap_uri = ldap://${LDAP_SERVER}:389
ldap_chpass_uri = ldap://${LDAP_SERVER}:389
ldap_network_timeout = 3
ldap_tls_cacertdir = ${CERTS}
krb5_kdcip = ${LDAP_SERVER}
krb5_server = ${LDAP_SERVER}
krb5_realm = ${KERBEROS_REALM}

[autofs]" > /etc/sssd/sssd.conf

chmod 600 /etc/sssd/sssd.conf

service sssd start
chkconfig sssd on
```
