#!/bin/bash
RELEASE=humio
NS=humio

helm repo add humio https://humio.github.io/humio-helm-charts 
helm repo update
oc create namespace $NS
oc project $NS
helm install -f humio-values.yml -n $RELEASE --namespace $NS humio/humio-helm-charts --tls
oc create -f hostpath-scc.yml
oc get scc humio-fluentbit
oc adm policy add-scc-to-user humio-fluentbit system:serviceaccount:humio:humio-fluentbit-read
oc expose svc humio-humio-core-http
kubectl patch ds humio-fluentbit --patch "$(cat ./scc_patch.yml)"
sleep 5
oc get po | grep humio-core | awk '{print $1}' | xargs kubectl delete pods
oc get po | grep humio-fluentbit | awk '{print $1}' | xargs kubectl delete pods
