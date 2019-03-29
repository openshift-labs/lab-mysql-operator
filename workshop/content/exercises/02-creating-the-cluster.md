---
Title: Creating the Cluster
PrevPage: 01-operator-prerequisites
NextPage: ../finish
---

Create secret to be used for MySQL cluster.

```execute-1
oc apply -f percona-xtradb-cluster-operator/deploy/secrets.yaml
```

Set up a watch of pods created for the MySQL cluster.

```execute-2
oc get pods -l name=percona-xtradb-cluster-operator --watch
```

Create the MySQL cluster.

```execute-1
oc apply -f percona-xtradb-cluster-operator/deploy/cr.yaml
```

Wait for all three pods to be created, one for each replica, then kill the watch.

```execute-2
<ctrl+c>
```
