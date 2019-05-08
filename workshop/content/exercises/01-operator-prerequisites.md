---
Title: Percona XtraDB Cluster Operator Prerequisites
PrevPage: ../index
NextPage: 02-create-cluster
---

The MySQL operator is installed into a project to monitor requests to create a MySQL cluster. The operator can only be deployed and setup by a cluster admin of the OpenShift cluster.

The MySQL operator has been pre-installed into your project and is ready for use during this workshop. Your user has been granted the appropriate permissions to create a managed MySQL database cluster.

To validate that your user has been granted the appropriate roles, you can use the `oc auth can-i` command to see whether you can create Kubernetes Custom Resources (CR) of the kind the Percona XtraDB MySQL Cluster Operator responds to.

The CR you need to create to declare a MySQL cluster is a Resource of the kind `PerconaXtraDBCluster` in the `pxc.percona.com` api group. To check that you can create this, run:

```execute
oc auth can-i create PerconaXtraDBCluster.pxc.percona.com
```

Did you type the command in yourself? If you did, click on the command here instead and you will find that it is executed for you. You can click on any command here in the workshop notes which has the <span class="glyphicon glyphicon-play-circle"></span> icon shown to the right of it, and it will be copied to the interactive terminal and run for you.

When run, if the response is `yes` you have the appropriate access.

We also need to verify that the MySQL operator has been deployed into your project. To check this, run:

```execute-1
oc rollout status deployment/percona-xtradb-cluster-operator
```

You should see a message:

```sh
deployment "percona-xtradb-cluster-operator" successfully rolled out
```

If the deployment hasn't yet completed, you will see progress messages as it starts up. Wait for the deployment to finish before proceeding.
