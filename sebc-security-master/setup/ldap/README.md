# Setting up LDAP

LDAP will be used in lieu of an Active Directory. The following has been tested in CentOS 7.x. If you are on a different version of Linux, your instructions may vary. You will start by installing the LDAP client on all hosts but you need to select a host on which you will install the LDAP server too.

On all hosts, perform the following steps. Make sure to update the LDAP_SERVER with the hostname of your selected host for it:

```
export LDAP_SERVER=myldapserver.sebc.org
export LDAP_SEARCH_BASE=dc=sebc,dc=org
export CERTS=/etc/openldap/certs
export DOMAIN=$(hostname -d | tr [a-z] [A-Z])

yum -y install openldap-clients

echo "
TLS_CACERTDIR    ${CERTS}
TLS_REQCERT never
URI ldap://${LDAP_SERVER}:389/
BASE ${DOMAIN}
BASE ${LDAP_SEARCH_BASE}" >> /etc/openldap/ldap.conf
```

Then on your LDAP_SERVER, make sure you also run the following (ensure you have the same variables from above set in your environment):

```
export LDAP_SERVER=myldapserver.sebc.org
export LDAP_SEARCH_BASE=dc=sebc,dc=org
export LDAP_ROOT_DC=sebc
export COUNTRY=US
export STATE=TX
export LOCALITY=Austin
export ORGNAME='SEBC Inc'
export ORGUNIT='IT'
export PASSWORD=passw0rd
export EMAIL=root@$(hostname -d)
export CERTS=/etc/openldap/certs

yum -y install openldap compat-openldap openldap-servers openldap-servers-sql openldap-devel

#sed -ibak "s/SLAPD_URLS=\"ldapi:/// ldap:///\"/SLAPD_URLS=\"ldapi:/// ldap:/// ldaps:///\"/g" /etc/sysconfig/slapd

service slapd start
chkconfig slapd on

echo "dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: ${LDAP_SEARCH_BASE}

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=admin,${LDAP_SEARCH_BASE}

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: $(slappasswd -s ${PASSWORD})" > db.ldif

ldapmodify -Y EXTERNAL  -H ldapi:/// -f db.ldif

echo "dn: olcDatabase={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0}to * by dn.base=\"gidNumber=0+uidNumber=0,cn=peercred,cn=external, cn=auth\" read by dn.base=\"cn=admin,${LDAP_SEARCH_BASE}\" read by * none" > monitor.ldif

ldapmodify -Y EXTERNAL  -H ldapi:/// -f monitor.ldif

cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
chown ldap:ldap /var/lib/ldap/*

ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif

service slapd restart

echo "dn: ${LDAP_SEARCH_BASE}
objectClass: top
objectClass: dcObject
objectclass: organization
o: Cloudera Inc
dc: ${LDAP_ROOT_DC}

dn: cn=admin,${LDAP_SEARCH_BASE}
objectClass: organizationalRole
cn: admin
description: Directory admin

dn: ou=people,${LDAP_SEARCH_BASE}
objectClass: organizationalUnit
ou: people
description: Generic people branch

dn: ou=groups,${LDAP_SEARCH_BASE}
objectClass: organizationalUnit
ou: groups
description: Generic groups branch

dn: ou=machines,${LDAP_SEARCH_BASE}
objectClass: organizationalUnit
ou: machines
description: Generic machines branch

dn: uid=admin,ou=people,${LDAP_SEARCH_BASE}
displayName: Administrator
cn: Administrator
givenName: Administrator
sn: None
initials: ADM
mail: admin@${DOMAIN}
uid: admin
uidNumber: 50000
gidNumber: 10000
homeDirectory: /home/admin
loginShell: /bin/bash
gecos: Administrator,,,,
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
userPassword: $(slappasswd -s ${PASSWORD})

dn: uid=user1,ou=people,${LDAP_SEARCH_BASE}
displayName: User 1
cn: User 1
givenName: User
sn: One
initials: US1
mail: user1@${DOMAIN}
uid: user1
uidNumber: 50001
gidNumber: 20000
homeDirectory: /home/user1
loginShell: /bin/bash
gecos: User 1,,,,
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
userPassword: $(slappasswd -s ${PASSWORD})

dn: uid=user2,ou=people,${LDAP_SEARCH_BASE}
displayName: User 2
cn: User 2
givenName: User
sn: Two
initials: US2
mail: user2@${DOMAIN}
uid: user2
uidNumber: 50002
gidNumber: 20000
homeDirectory: /home/user2
loginShell: /bin/bash
gecos: User 2,,,,
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
userPassword: $(slappasswd -s ${PASSWORD})

dn: uid=user3,ou=people,${LDAP_SEARCH_BASE}
displayName: User 3
cn: User 3
givenName: User
sn: Three
initials: US3
mail: user3@${DOMAIN}
uid: user3
uidNumber: 50003
gidNumber: 20000
homeDirectory: /home/user3
loginShell: /bin/bash
gecos: User 3,,,,
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
userPassword: $(slappasswd -s ${PASSWORD})

dn: uid=user4,ou=people,${LDAP_SEARCH_BASE}
displayName: User 4
cn: User 4
givenName: User
sn: Four
initials: US4
mail: user4@${DOMAIN}
uid: user4
uidNumber: 50004
gidNumber: 20000
homeDirectory: /home/user4
loginShell: /bin/bash
gecos: User 4,,,,
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
userPassword: $(slappasswd -s ${PASSWORD})

dn: cn=admins,ou=groups,${LDAP_SEARCH_BASE}
cn: admins
description: Admins of the enterprise
gidNumber: 10000
objectClass: posixGroup
memberUid: admin

dn: cn=users,ou=groups,${LDAP_SEARCH_BASE}
cn: users
description: Users of the enterprise
gidNumber: 20000
objectClass: posixGroup
memberUid: user1
memberUid: user2
memberUid: user3
memberUid: user4

dn: cn=managers,ou=groups,${LDAP_SEARCH_BASE}
cn: managers
description: Managers of the enterprise
gidNumber: 20001
objectClass: posixGroup
memberUid: user1
memberUid: user3

dn: cn=analysts,ou=groups,${LDAP_SEARCH_BASE}
cn: analysts
description: Analysts of the enterprise
gidNumber: 20002
objectClass: posixGroup
memberUid: user2
memberUid: user4" > populate.ldif

ldapadd -x -D cn=admin,${LDAP_SEARCH_BASE} -H ldap://${LDAP_SERVER}:389 -w ${PASSWORD} -f populate.ldif
```
