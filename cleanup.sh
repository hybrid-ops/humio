#!/bin/bash

helm3 uninstall humio
kubectl delete namespace humio --cascade=true
oc delete scc humio-fluentbit
oc delete ds humio-fluentbit
oc adm policy remove-scc-from-user humio-fluentbit system:serviceaccount:humio:humio-fluentbit-read