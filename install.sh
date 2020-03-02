#!/bin/bash

helm3 repo add humio https://humio.github.io/humio-helm-charts 
helm3 repo update
oc create namespace humio
helm3 install -f humio-values.yml --namespace humio humio humio/humio-helm-charts
oc create -f hostpath-scc.yml
oc get scc humio-fluentbit
oc adm policy add-scc-to-user humio-fluentbit system:serviceaccount:humio:humio-fluentbit-read
oc expose svc humio-humio-core-http
