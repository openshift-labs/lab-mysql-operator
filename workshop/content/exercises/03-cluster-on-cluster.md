---
Title: Database Cluster on OpenShift
PrevPage: 02-create-cluster
NextPage: 04-operator-at-work
---

## Kubernetes cluster elements

In the previous step, we instantiated a `PerconaXtraDBCluster` resource (a `pxc`, for short). We can see this by looking at the Custom Resource (CR) we created. An excerpt from its manifest file, `mysql-cluster.yaml`, shows what `kind` of Resource our `cluster1` is.

```yaml
apiVersion: "pxc.percona.com/v1alpha1"
kind: "PerconaXtraDBCluster"
metadata:
  name: "cluster1"
```

You can examine the entire manifest for the database cluster Custom Resource:

```execute-1
less mysql-cluster.yaml
```

(Press `q` to exit the pager.)

Since Custom Resource Definitions (CRDs) extend the Kubernetes API on our cluster, we can handle a `pxc` as a first-class resource. API tools like `oc` or `kubectl` can `get` and `describe` the `pxc` we spun up, for example:

```execute-1
oc get pxc cluster1
```

```execute-1
oc describe pxc cluster1
```

`Describe`-ing our `pxc`, `cluster1`, shows details about the database cluster, including its demands for underlying cluster resources and its size &ndash; the number of member pods to spread across the OpenShift cluster.

Notice how the living Custom Resource running on the cluster matches up to its manifest in the `mysql-cluster.yaml` file we looked at above. The elements of both were specified in the CRD created in advance by the OpenShift administrator.

```sh
  Pxc:
    Affinity:
      Anti Affinity Topology Key:  none
    Allow Unsafe Configurations:   false
    Image:                         percona/percona-xtradb-cluster-operator:1.1.0-pxc
    Pod Disruption Budget:
      Max Unavailable:  1
    Resources:
      Requests:
        Cpu:     600m
        Memory:  1G
    Size:        3
```

Let's stop the pod watch to free the lower terminal once we know all three members of the MySQL database cluster are running. You should see the following in the lower terminal:

```
NAME                  READY     STATUS    RESTARTS   AGE
cluster1-proxysql-0   3/3       Running   0          5m
cluster1-pxc-0        1/1       Running   0          5m
cluster1-pxc-1        1/1       Running   0          4m
cluster1-pxc-2        1/1       Running   0          2m
```

Once you see all three pods are ready, kill the watch by running:

```execute-2
<ctrl+c>
```
