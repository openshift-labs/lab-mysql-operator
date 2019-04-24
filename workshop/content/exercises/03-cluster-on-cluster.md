---
Title: Database Cluster on OpenShift
PrevPage: 02-create-cluster
NextPage: 04-connect-to-cluster
---

## Kubernetes cluster elements

In the previous step, we instantiated a `PerconaXtraDBCluster` resource (a `pxc`, for short). We can see this by looking at the Custom Resource (CR) we created. An excerpt from its manifest file, `mysql-cluster.yaml`, shows what `kind` of Resource our `cluster1` is.

```yaml
apiVersion: "pxc.percona.com/v1alpha1"
kind: "PerconaXtraDBCluster"
metadata:
  name: "cluster1"
```

Since Custom Resource Definitions (CRDs) extend the Kubernetes API on our cluster, we can handle a `pxc` as a first-class resource. API tools like `oc` or `kubectl` can `get` and `describe` the `pxc` we spun up, for example:

```execute-1
oc get pxc cluster1
```

```execute-1
oc describe pxc cluster1
```

`Describe`-ing our `pxc`, `cluster1`, shows details about the database cluster, including its demands for underlying cluster resources and its size &ndash; the number of member pods to spread across the OpenShift cluster.

Notice how the living Custom Resource running on the cluster matches up to its manifest in the `cr.yaml` file we looked at above. The elements of both were specified in the CRD created in advance by the OpenShift administrator.

```sh
  Pxc:
    Affinity:
      Anti Affinity Topology Key:  none
    Allow Unsafe Configurations:   false
    Image:                         percona/percona-xtradb-cluster-operator:0.3.0-pxc
    Pod Disruption Budget:
      Max Unavailable:  1
    Resources:
      Requests:
        Cpu:     600m
        Memory:  1G
    Size:        3
```

Let's stop the pod watch to free the lower terminal now that we know all three members of the MySQL database cluster are running.

```execute-2
<ctrl+c>
```

## Operator at Work

### Scaling the pxc

If we declare a new desired state, the Operator will try to update the MySQL cluster's actual state to match. We can scale the database cluster up or down by changing the desired state for the `pxc`'s `size`.

Follow a cluster member pod's log to see what happens when we scale up to the new desired state:

```execute-2
oc logs cluster1-proxysql-0 -c proxysql --follow
```

Apply the new desired state. Here, we do this on the fly by getting, modifying, and re-`apply`ing the `pxc` we deployed earlier. Let's change the database cluster's size from 3 members to 5:

```execute-1
oc get pxc/cluster1 -o yaml | sed -e 's/size: 3/size: 5/' | oc apply -f -
```

Since `oc apply` returns asynchronously, you can watch pod events in the upper terminal now:

```execute-1
watch oc get pods -l app=pxc,cluster=cluster1
```

Interupt the watch and the log follow once you've observed the Operator scaling its `pxc/cluster1` MySQL cluster.

```execute-1
<ctrl+c>
```

```execute-2
<ctrl+c>
```

### A Bit of the Old Ultraviolence

What happens if you kill one of the member pods of our `pxc/cluster1` database cluster?

Let's watch:

```execute-2
watch oc get pods -l app=pxc,cluster=cluster1
```

**NOTE**: Make sure the watch shows at least 3 database cluster Pods, `cluster1-pxc-0`, `-1`, and `-2`, each with `1/1` of their containers in the `READY` state before deleting the pod in the next step.

```execute-1
oc delete pod cluster1-pxc-2
```

In the bottom terminal's pod watch, you can see member pod `cluster1-pxc-2` terminate. Next, you'll see a new replica started by the pxc Operator to replace it.

Once you've seen a simple node failure recovery, stop the pod watch.

```execute-2
<ctrl+c>
```
