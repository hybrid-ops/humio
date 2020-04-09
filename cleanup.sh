#!/bin/bash
NAMESPACE=humio
RELEASENAME=humio

helm delete $RELEASENAME --purge --tls
kubectl delete namespace $NAMESPACE --cascade=true
oc delete scc humio-fluentbit
oc delete ds humio-fluentbit
oc adm policy remove-scc-from-user humio-fluentbit system:serviceaccount:humio:humio-fluentbit-read
