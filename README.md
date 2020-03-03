# humio
## Log manager for BoD

### Run Instructions
- Log into the cluster (in this case the hub cluster)
- If you haven't already, clone this repo to your boot node. 
- Change directory into humio directory and edit humio-values.yml if needed. Some variables that are commonly changed. Otherwise the default works for a MCM hub:
   - Number of replicas
   - StorageClass
- Run `install.sh` with no arguments. This will install the humio release under namespace `humio`.
```
# ./install.sh
```
- Edit the `humio-fluentbit` daemonset:
```
# oc edit ds humio-fluentbit
```
- Add this to `spec.template.spec.containers` section:
```
securityContext:
  privileged: true
```
- Ensure the pods are running:
``` 
# oc get po -n humio
NAME                                   READY     STATUS              RESTARTS   AGE
humio-balance-hjsv4                    0/1       Completed           0          3h
humio-cp-kafka-0                       2/2       Running             1          72s
humio-cp-kafka-1                       2/2       Running             0          29s
humio-cp-kafka-2                       2/2       Running             0          10s
humio-cp-zookeeper-0                   2/2       Running             0          3h
humio-cp-zookeeper-1                   2/2       Running             0          3h
humio-cp-zookeeper-2                   2/2       Running             0          3h
humio-create-shared-tokens-bmj24       0/1       Completed           0          3h
humio-create-single-user-token-h5mck   0/1       Completed           0          3h
humio-fluentbit-2gxmz                  1/1       Running             0          171m
humio-fluentbit-47d6l                  1/1       Running             0          171m
humio-fluentbit-4kx48                  1/1       Running             0          171m
humio-fluentbit-6cfv8                  1/1       Running             0          171m
humio-fluentbit-7llq4                  1/1       Running             0          171m
humio-fluentbit-7mtwr                  1/1       Running             0          171m
humio-fluentbit-8fsp6                  1/1       Running             0          171m
humio-fluentbit-8pbw5                  1/1       Running             0          171m
humio-fluentbit-bd5lh                  1/1       Running             0          171m
humio-fluentbit-dz24l                  1/1       Running             0          171m
humio-fluentbit-f59p4                  1/1       Running             0          171m
humio-fluentbit-fhr9l                  1/1       Running             0          171m
humio-fluentbit-gtgvb                  1/1       Running             0          171m
humio-fluentbit-hm2xw                  1/1       Running             0          171m
humio-fluentbit-jckz2                  1/1       Running             0          171m
humio-fluentbit-jd2h7                  1/1       Running             0          171m
humio-fluentbit-mqgc7                  1/1       Running             0          171m
humio-fluentbit-mrstj                  1/1       Running             0          171m
humio-fluentbit-qk258                  1/1       Running             0          171m
humio-fluentbit-qxgl2                  1/1       Running             0          171m
humio-fluentbit-w8vv7                  1/1       Running             0          171m
humio-fluentbit-wldhn                  1/1       Running             0          171m
humio-fluentbit-z5grl                  1/1       Running             0          171m
humio-humio-core-0                     1/1       Running             3          114s
humio-humio-core-1                     1/1       Running             1          2m29s
humio-humio-core-2                     1/1       Running             0          2m
humio-humio-core-3                     1/1       Running             1          2m23s
humio-humio-core-4                     1/1       Running             1          2m25s
```
- Run `collect.sh` with no arguments to get the password and console

### Uninstalling Humio
- Run `cleanup.sh` with no arguments.

### File summary

- `install.sh`: Main script that installs the humio helm chart and other things. Take a look at `install.sh` to see the individual steps. Also notice the storage class is `gp2` which is what AWS is using. 
- `cleanup.sh`: Uninstall script
- `collect.sh`: Get the password and exposed URL for the Humio console
- `hostpath-scc.yml`: SCC for hostpath (install.sh uses this file)
- `humio-values.yml`: humio release values


