#!/bin/bash

set -x
set -eo pipefail

oc delete clusterrole pxc-admin
oc delete crd perconaxtradbclusters.pxc.percona.com \
              perconaxtradbbackups.pxc.percona.com
