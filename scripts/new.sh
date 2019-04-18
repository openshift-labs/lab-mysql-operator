#! /usr/bin/env bash

# new.sh - Production deploy lab-mysql-operator homeroom
#
# This script calls the others rather than modifying them because
# 1. anyuid for all auth'd users is bad practice
# 2. ACME TLS may not be desirable in all deploys

# Basic setup, as in README: New namespace, deploy spawner, and build local
# workshop src imagestream tag. Stop building local src after push upstream.
oc new-project workshops
./scripts/deploy-spawner.sh
#./scripts/build-workshop.sh # To use local workshop source.

# Gross. Relax scc to allow any authenticated user on entire cluster to run
# container with anyuid, including root. For library/wordpress image.
oc adm policy add-scc-to-group anyuid system:authenticated #Once per cluster

# Better practice: Add openshift-acme TLS and give the route a cert.
oc create -fhttps://raw.githubusercontent.com/tnozicka/openshift-acme/master/deploy/letsencrypt-live/single-namespace/{role,serviceaccount,imagestream,deployment}.yaml #Once per project
oc policy add-role-to-user openshift-acme --role-namespace="$(oc project --short)" -z openshift-acme
oc annotate route mysql-lab --overwrite kubernetes.io/tls-acme=true

# Return the workshop route URL
oc get route mysql-lab
