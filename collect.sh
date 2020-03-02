#!/bin/bash

echo ""
echo "Humio console:"
oc get routes
echo ""

echo ""
echo "Developer password for Humio console:
oc get secret developer-user-password -o=template --template={{.data.password}} | base64 -d
echo ""
echo ""
