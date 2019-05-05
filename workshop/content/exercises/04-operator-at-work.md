---
Title: The Operator at Work
PrevPage: 03-cluster-on-cluster
NextPage: 05-connect-to-cluster
---

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

In the bottom terminal's pod watch, you can see member pod `cluster1-pxc-2` terminate:

```
NAME                  READY     STATUS        RESTARTS   AGE
cluster1-proxysql-0   3/3       Running       0          9m
cluster1-pxc-0        1/1       Running       0          10m
cluster1-pxc-1        1/1       Running       0          8m
cluster1-pxc-2        1/1       Terminating   0          6m
cluster1-pxc-3        0/1       Running       0          1m
```

Next, you'll see a new replica started by the pxc Operator to replace it:

```
NAME                  READY     STATUS    RESTARTS   AGE
cluster1-proxysql-0   3/3       Running   0          12m
cluster1-pxc-0        1/1       Running   0          12m
cluster1-pxc-1        1/1       Running   0          10m
cluster1-pxc-2        1/1       Running   0          2m
cluster1-pxc-3        1/1       Running   0          3m
cluster1-pxc-4        0/1       Running   0          1m
```

Once you've seen a simple node failure recovery, stop the pod watch.

```execute-2
<ctrl+c>
```
