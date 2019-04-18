---
Title: Percona XtraDB Cluster Operator Prerequisites
PrevPage: ../index
NextPage: 02-create-cluster
---

The MySQL operator is installed into a project to monitor requests to create a MySQL cluster. The operator can only be deployed and setup by a cluster admin of the OpenShift cluster.

In this workshop environment, the MySQL operator has been pre-installed into your project ready for use. The user you are running the workshop as, has also been delegated the appropriate roles to allow it to create a MySQL cluster.

To validate that your user has been granted the appropriate roles, you can use the `oc auth can-i` command to see whether you can create Kubernetes Custom Resources (CR) of the kind the Percona XtraDB MySQL Cluster Operator responds to.

The CR you need to create to declare a MySQL cluster is a Resource of the kind `PerconaXtraDBCluster` in the `pxc.percona.com` api group. To check that you can create this, run:

```execute
oc auth can-i create PerconaXtraDBCluster.pxc.percona.com
```

If response is `yes`, you have the appropriate access.

We also need to verify that the MySQL operator has been deployed into your project. To check this, run:

```execute-1
oc rollout status deployment/percona-xtradb-cluster-operator
```

You should see a message:

```sh
deployment "percona-xtradb-cluster-operator" successfully rolled out
```

If the deployment hasn't yet completed, you will see progress messages as it starts up. Wait for the deployment to finish before proceeding.
