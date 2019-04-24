#!/bin/bash

set -x

oc delete clusterrole pxc-admin
oc delete crd perconaxtradbclusters.pxc.percona.com \
              perconaxtradbbackups.pxc.percona.com
