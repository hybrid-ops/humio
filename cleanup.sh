#!/bin/bash
RELEASE=humio
NS=humio

helm delete $RELEASE --purge --tls
kubectl delete namespace $NS --cascade=true
oc delete scc humio-fluentbit
oc delete ds humio-fluentbit
oc adm policy remove-scc-from-user humio-fluentbit system:serviceaccount:humio:humio-fluentbit-read
