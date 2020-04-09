#!/bin/bash

RELEASENAME=humio
NAMESPACE=humio

helm repo add $RELEASENAME https://humio.github.io/humio-helm-charts
helm repo update
oc create namespace $NAMESPACE
oc project $NAMESPACE
helm install -f humio-values.yml -n $RELEASENAME --namespace $NAMESPACE humio/humio-helm-charts --tls
oc create -f hostpath-scc.yml
oc get scc humio-fluentbit
oc adm policy add-scc-to-user humio-fluentbit system:serviceaccount:humio:humio-fluentbit-read
kubectl patch ds humio-fluentbit --patch "$(cat ./scc_patch.yml)"
sleep 5
oc expose svc humio-humio-core-http
oc get po | grep humio-core | awk '{print $1}' | xargs kubectl delete pods
oc get po | grep humio-fluentbit | awk '{print $1}' | xargs kubectl delete pods
