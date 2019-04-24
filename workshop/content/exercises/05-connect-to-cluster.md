---
Title: Connecting to the MySQL Cluster
PrevPage: 04-operator-at-work
NextPage: 06-deploy-app
---

Start a pod running a MySQL command-line client. When this command completes, you'll be at the prompt for a shell in the new `mycli` pod, from which you can login to the MySQL monitor to query the XtraDB cluster.

```execute-1
oc run mycli -i -t --rm --restart=Never --image=mysql -- /bin/bash
```

### ProxySQL

The Operator deploys the [ProxySQL proxy in front of the cluster to handle load-balancing of queries between XtraDB Cluster members][proxysql], while presenting a familiar interface to MySQL clients. In our cluster, the Operator has set up a Kubernetes Service. Since we're running on the cluster, we can connect to the SQL proxy by name: `cluster1-proxysql`.

```execute-1
mysql -h cluster1-proxysql -u root -p
```

At the prompt, type the database admin password you decoded earlier, `root_password`, then hit Enter.

Once logged in to the mysql monitor, you'll see the prompt change to `mysql>`. The XtraDB cluster maintains some extra status about the state of the cluster. You can query database cluster replication status, for instance:

```execute-1
show status like 'wsrep%';
```

And of course you can do normal SQL database operations. For example, we can discover the databases on the server:

```execute-1
show databases;
```

Take a look at the usual tables in the standard `mysql` configuration database:

```execute-1
use mysql;
show tables;
```

Check out the `user` records for the user you're logged into the MySQL monitor as, `root`:

```execute-1
SELECT * FROM user WHERE User='root';
```

Before moving on, quit the MySQL monitor:

```execute-1
quit
```

and exit the shell inside the MySQL client pod:

```execute-1
exit
```

[proxysql]: https://www.percona.com/doc/percona-xtradb-cluster/LATEST/howtos/proxysql.html#load-balancing-with-proxysql
