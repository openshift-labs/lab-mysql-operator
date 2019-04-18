---
Sort: 1
Title: Workshop Overview
NextPage: exercises/01-operator-prerequisites
ExitSign: Start Workshop
---

[Wikipedia describes MySQL][wiki-mysql] as:

> a relational database management system (RDBMS). Its name is a combination of "My", the name of co-founder Michael Widenius's daughter, and "SQL", the abbreviation for Structured Query Language.

MySQL applications at large scale usually require a MySQL server cluster for performance and reliability. Managing such a cluster involves setting up communication and authentication between the members, designating write leaders and read followers, and other intricacies.

[Percona XtraDB MySQL Cluster][pxchome] is an open source MySQL® clustering solution.

In this workshop, you will learn how to create a MySQL cluster using Percona's XtraDB MySQL Cluster Operator on an OpenShift cluster. OpenShift is Red Hat's distribution of the Kubernetes cluster orchestrator.

[pxchome]: https://www.percona.com/software/mysql-database/percona-xtradb-cluster
[wiki-mysql]: https://en.wikipedia.org/wiki/MySQL
