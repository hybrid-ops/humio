#!/bin/bash

helm3 repo add humio https://humio.github.io/humio-helm-charts 
helm3 repo update
oc create namespace humio
oc project humio
helm3 install -f humio-values.yml --namespace humio humio humio/humio-helm-charts
oc create -f hostpath-scc.yml
oc get scc humio-fluentbit
oc adm policy add-scc-to-user humio-fluentbit system:serviceaccount:humio:humio-fluentbit-read
#kubectl patch ds humio-fluentbit --patch "$(cat ./scc_patch.yml)"
oc get po | grep humio-core | awk '{print $1}' | xargs kubectl delete pods
oc get po | grep humio-fluentbit | awk '{print $1}' | xargs kubectl delete pods
oc expose svc humio-humio-core-http
