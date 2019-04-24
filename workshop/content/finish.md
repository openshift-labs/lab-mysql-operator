---
Sort: 3
Title: Workshop Summary
ExitSign: Finish Workshop
---

## Percona XtraDB Mysql Cluster Operator

In this lab, we used the [Percona XtraDB Cluster Operator][pxchome] to deplay a MySQL server cluster on [Red Hat OpenShift][openshift]. With a managed db cluster in place, we deployed the popular WordPress CMS using our `pxc/cluster1` as a backend to store WordPress's data. We experimented with how the Operator allows scaling, recovering, and managing the database cluster in common Kubernetes terms, showing how [Operators][operator-gh-org] extend clusters running Kubernetes and Kubernetes distributions like OpenShift to create custom first-class API resources.

## Keep Learning

* The [introductory Operators blog post][operators-intro] is a good place to get more background about the Operator pattern.
* There are more interactive tutorials ready to run on live clusters in the [OpenShift Learning Portal's Operators section][learn-operators].
* The [Operator Hub][operatorhub] curates dozens of Operators ready to manage foundation software on your behalf on OpenShift and Kubernetes clusters.
* To get started building Operators to manage your own applications on Kubernetes clusters, check out the [Operator SDK][operator-sdk].

**Thanks for Playing!**

[learn-operators]: https://learn.openshift.com/operatorframework/
[openshift]: https://openshift.com
[operator-gh-org]: https://github.com/operator-framework
[operators-intro]: https://blog.openshift.com/introducing-the-operator-framework/
[operator-sdk]: https://github.com/operator-framework/operator-sdk
[operatorhub]: https://operatorhub.io
[pxchome]: https://www.percona.com/software/mysql-database/percona-xtradb-cluster
