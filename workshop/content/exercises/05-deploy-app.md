---
Title: Deploying an Application
PrevPage: 04-connect-to-cluster
NextPage: ../finish
---

[WordPress][wp] is one of the most popular open-source applications backed by a MySQL database. Now we can deploy a scaleable, clustered WordPress atop our Percona XtraDB Cluster. WordPress is available from the Docker Hub library:

```execute-1
oc new-app wordpress --env WORDPRESS_DB_HOST=cluster1-proxysql --env WORDPRESS_DB_USER=root --env WORDPRESS_DB_PASSWORD=root_password
```

`Oc`'s `new-app` subcommand created a Service providing a stable in-cluster endpoint for the dynamic Pod(s) running WordPress. We can create a Route pointing to that Service, so that a web browser can reach your site:

```execute-1
oc expose service/wordpress
```

Retrieve the route info, and visit the generated URL in a new browser tab to set up WordPress with a site name and admin user.

```execute-1
oc get routes
```

After WordPress's "famous five-minute install" creates and populates its database on the XtraDB Cluster, you can log in to your new WordPress site, backed by an automated 5-node Percona XtraDB MySQL Cluster.

[wp]: https://wordpress.org
