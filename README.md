Lab - Percona XtraDB MySQL Cluster Operator
====================

This workshop deploys a MySQL cluster using the [Percona XtraDB MySQL Cluster (PXC) Operator][pxcohome]. Use of the operator is from the perspective of a developer.

The workshop uses the HomeRoom workshop environment in the learning portal configuration. You need to be a cluster admin to deploy it.

When the URL for the workshop environment is accessed, a workshop session will be created on demand. This includes a project for the session, into which the PXC operator will have been pre-installed.

Deploying the Workshop - "Production" Deployment
----------------------

To deploy the workshop, clone this repository and run the new deployment script. Note that `new.sh` calls both the deploy-spawner and build-workshop scripts, so the workshop image stream tag will be built from these local workshop sources.

```sh
./scripts/new.sh
```

`New.sh` also deploys openshift-acme to manage Let's Encrypt TLS certificates for the lab's Route.

To edit and iteratively deploy local workshop sources, or to redeploy the spawner after making RBAC or setup resources changes, see below.

Deploying the Workshop - Development Cycle
----------------------

To deploy the workshop, first clone this Git repository to your own machine.

Next create a project in OpenShift into which the workshop is to be deployed.

```
oc new-project workshops
```

From within the top level of the Git repository, now run:

```
./scripts/deploy-spawner.sh
```

The name of the deployment will be ``mysql-lab``.

You can determine the hostname for the URL to access the workshop by running:

```
oc get route mysql-lab
```

Editing the Workshop
--------------------

The deployment created above will use a version of the workshop which has been pre-built into an image and which is hosted on ``quay.io``.

To make changes to the workshop content and test them, edit the files in the Git repository and then run:

```
./scripts/build-workshop.sh
```

This will replace the existing image used by the active deployment.

If you are running an existing instance of the workshop, from your web browser select "Restart Workshop" from the menu top right of the workshop environment dashboard.

When you are happy with your changes, push them back to the remote Git repository. This will automatically trigger a new build of the image hosted on ``quay.io``.

If you need to change the RBAC definitions, or what resources are created when a project is created, change the definitions in the ``templates`` directory. You can then re-run:

```
./scripts/deploy-spawner.sh
```

and it will update the active definitions.

Note that if you do this, you will need to re-run:

```
./scripts/build-workshop.sh
```

to have any local content changes be used once again as it will revert back to using the image on ``quay.io``.

Deleting the Workshop
---------------------

To delete the spawner and any active sessions, including projects, run:

```
./scripts/delete-spawner.sh
```

To delete the build configuration for the workshop image, run:

```
./scripts/delete-workshop.sh
```

To delete special resources for CRDs and cluster roles for the MySQL operator, run:

```
./scripts/delete-resources.sh
```

Only delete these last set of resources if the MySQL operator is not being used elsewhere in the cluster. Ideally this workshop environment should only be deployed in an expendable cluster, and not one which is shared for other work.

[pxcohome]: https://github.com/percona/percona-xtradb-cluster-operator
