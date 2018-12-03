# Setting up Sentry

Sentry allows us to GRANT and REVOKE access to various Hive SQL resources (e.g., databases, tables, columns). For Sentry to work, we must make sure that ALL hosts have the same user and group information. This is why getting LDAP and SSSD working prperly on ALL hosts is important. To verify that ALL hosts have the same user and group information, use the following command:

```
id <user>
getent group <group>
```

Replace <user> with one of the pre-created users (e.g., admin, user1, user2, etc.) and group with one of the pre-created groups (e.g., admins, users). You should see consistent information between all hosts. If you do, you are ready to start configuring Sentry. Read over the following <a href="https://www.cloudera.com/documentation/enterprise/5-13-x/topics/sg_sentry_overview.html">documentation</a> to enable Sentry.

Your goal on this bootcamp is to accomplish the following:

<li>Configure Sentry with the admin user as Sentry administrator</li>
<li>Connect as user admin to Hive using beeline</li>
<li>GRANT ALL privileges to the admin user</li>
<li>Create two tables under the default database. Name them 'table1' and 'table2' (make a simple CSV schema for each)</li>
<li>Create roles 'managers' and 'analysts' mapped to the corresponding groups with the same name</li>
<li>GRANT ALL privileges to the 'managers' role on table 'table1'</li>
<li>GRANT SELECT privileges to the 'analysts' role on table 'table2'</li>
<li>Load each table with some sample data</li>
<li>Authenticate with user1 and connect to Hive via beeline. Perform a SELECT * on table1 and then on table2.</li>
<li>Authenticate with user2 and connect to Hive via beeline. Perform a SELECT * on table1 and then on table2.</li>

<br/>

Elaborate what you noticed. Upload your <a href="config/output.txt">response</a> showing also the output from the commands.
