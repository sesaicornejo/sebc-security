# Data-at-Rest Encryption

Data-at-Rest (DARE) encryption comes in two flavors:

<li>HDFS Transparent Encryption</li>
<li>Navigator Encrypt</li>

<br/>

HDFS encryption is used for encryption of HDFS blocks stored in DataNodes whereas Navigator Encrypt is used for encryption of non-HDFS volumes such as data disks for Kafka or databases. Both prevent access to data sitting on disk in the event a disk is pulled out.

In the case of HDFS encryption, one must create encryption keys and encryption zones (which start as empty HDFS directories) associated to an encryption key. Once an encryption zone and corresponding encryption key are created, ACLs must be configured on the key for the various key operations. The ACLs are managed by the Key Management Server (KMS). 

For Navigator Encrypt, volumes are mounted under a Linux directory (vs. an HDFS directory as is the case with HDFS encryption) and all data in the volume (disk) is encrypted. Navigator Encrypt does not allow for encryption of some directories under the same volume or disk so all data on disk is encrypted.

For this bootcamp, your job is to become familiar with HDFS Encryption by reading over the information posted <a href="https://www.cloudera.com/documentation/enterprise/5-13-x/topics/cdh_sg_hdfs_encryption.html">here</a>. Then describe the process for the following situation:

Imagine you have a customer with 40 TB of data in /user/hive/warehouse. HDFS Encryption was not enabled and a customer is now interested in encrypting all data under /user/hive/warehouse. Describe what steps would you take to encrypt the data. What would you and/or the customer need to do to ensure that encryption of all data is posslbe? Be as detailed in your <a href="config/response.txt">response</a>.
