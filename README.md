
<img src="https://avatars.githubusercontent.com/u/54386046?v=4" width="200"/>

# jmeter-influxdb-no-jdk
## Docker image of JMeter w/ InfluxDB plugin using shared host alpine version jdk

<br>

### Mount your jdk/jmx plan(with `InfluxDB Backend Listener`)
<br>

## Example 1
```
apiVersion: batch/v1
kind: Job
metadata:
    name: sc-job-jmeter
    namespace: sc-devops
    labels:
        app: sc-job-jmeter
spec:
    ttlSecondsAfterFinished: 5
    backoffLimit: 5
    parallelism: 1
    template:
        metadata:
            labels:
                app: sc-job-jmeter
        spec:
            volumes:
            - name: configs
                hostPath:
                    path: /mnt/configs
            - name: log
              hostPath:
                    path: /mnt/log
            containers:
            - name: sc-job-jmeter
              image: senmicloud/jmeter-influxdb-no-jdk

              volumeMounts:
                - name: configs
                  mountPath: /jmeter
                  subPath: sc-job-jmeter

                - name: configs
                  mountPath: /opt/openjdk
                  subPath: openjdk-17
                  readOnly: true

                - name: log
                  mountPath: /log
                  subPath: sc-job-jmeter
```
## Example 2
```
apiVersion: batch/v1
kind: Job
metadata:
    name: sc-job-jmeter
    namespace: sc-devops
    labels:
        app: sc-job-jmeter
spec:
    ttlSecondsAfterFinished: 5
    backoffLimit: 5
    parallelism: 1
    template:
        metadata:
            labels:
                app: sc-job-jmeter
        spec:
            volumes:
            - name: configs
                hostPath:
                    path: /mnt/configs
            - name: log
              hostPath:
                    path: /mnt/log
            containers:
            - name: sc-job-jmeter
              image: senmicloud/jmeter-influxdb-no-jdk

              command: [ "sh", "-c"]
              args:
                - |
                  rm -rf /jmeter/result/*

                   jmeter -n -Dlog4j2.formatMsgNoLookups=true -t /jmeter/plan/load-test-plan.jmx -l /jmeter/result/load-test-result.jtl -e -o /jmeter/result -j /log/sc-job-jmeter.log

              volumeMounts:
                - name: configs
                  mountPath: /jmeter
                  subPath: sc-job-jmeter

                - name: configs
                  mountPath: /opt/openjdk
                  subPath: openjdk-17
                  readOnly: true

                - name: log
                  mountPath: /log
                  subPath: sc-job-jmeter
```
---
## Volumes to mount
```
├─ /mnt/configs/
│  ├─ sc-job-jmeter
│  │  ├─ plan
│  │  │  └─  planyour-plan.jmx
│  │  └─ result
│  └─ openjdk-17
```