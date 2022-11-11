    sudo buildctl build \
        --frontend=dockerfile.v0 \
        --local context=. \
        --local dockerfile=. \
        --export-cache type=local,dest=/tmp/buildctl-cache/jmeter-influxdb-no-jdk \
        --import-cache type=local,src=/tmp/buildctl-cache/jmeter-influxdb-no-jdk \
        --output type=image,name=docker.io/senmicloud/jmeter-influxdb-no-jdk:latest,unpack=true