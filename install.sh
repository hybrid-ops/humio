#!/bin/bash

helm repo add humio https://humio.github.io/humio-helm-charts 
helm repo update
oc create namespace humio
oc project humio
helm install -f humio-values.yml -n humio --namespace humio humio/humio-helm-charts --tls
oc create -f hostpath-scc.yml
oc get scc humio-fluentbit
oc adm policy add-scc-to-user humio-fluentbit system:serviceaccount:humio:humio-fluentbit-read
#kubectl patch ds humio-fluentbit --patch "$(cat ./scc_patch.yml)"
#oc get po | grep humio-core | awk '{print $1}' | xargs kubectl delete pods
#oc get po | grep humio-fluentbit | awk '{print $1}' | xargs kubectl delete pods
oc expose svc humio-humio-core-http
