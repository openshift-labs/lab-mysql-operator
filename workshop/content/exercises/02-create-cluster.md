---
Title: Declaring an XtraDB MySQL Cluster
PrevPage: 01-operator-prerequisites
NextPage: 03-cluster-on-cluster
---

First, we will create a Kubernetes *Secret* to hold MySQL cluster account configuration. Secrets are base64 encoded, so we can decode the value in the Secret's manifest to learn the MySQL `root` password we'll be setting. The following one-liner looks for root's record in the Secret's manifest, strips the result down to just the password value, and decodes that value into plain text:

```execute-1
echo $(grep root secrets.yaml | sed 's/  root: //' | base64 --decode)
```

The text `root_password` should be printed on the standard output.

Apply this manifest to create an instance of the Secret on your OpenShift cluster:

```execute-1
oc apply -f secrets.yaml
```

Set up a watch to see the Pods that will be created for the MySQL cluster. This will display in the lower terminal.

```execute-2
watch oc get pods -l app.kubernetes.io/component=pxc,app.kubernetes.io/instance=cluster1
```

Create the MySQL cluster by applying the Custom Resource manifest to the OpenShift cluster:

```execute-1
oc apply -f mysql-cluster.yaml
```

Three pods will be created, one for each database cluster member, named `cluster1-pxc-0`, `cluster1-pxc-1`, and so on. You can watch them spin up in the lower terminal as you proceed to the next section. However, you can interact with databases as soon as the first database cluster pod, `cluster1-pxc-0`, shows `1/1`containers in the `READY` state column. The Operator and XtraDB Cluster logic handle replication to new database cluster member pods as they come online.
