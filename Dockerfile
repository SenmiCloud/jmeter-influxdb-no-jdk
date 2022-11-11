FROM alpine:latest
LABEL maintainer="Ares"
ENV JMETER_VERSION=5.5
ENV JMETER_INFLUXDB_PLUGIN_VERSION=2.5
ENV JMETER_DOWNLOAD_URL=https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_HOME=/opt/apache-jmeter-${JMETER_VERSION}
ENV JAVA_HOME=/opt/openjdk
ENV PATH=$JAVA_HOME/bin:$JMETER_HOME/bin:$PATH
RUN cd /opt && wget $JMETER_DOWNLOAD_URL && tar -xzf apache-jmeter-${JMETER_VERSION}.tgz && rm -rf apache-jmeter-${JMETER_VERSION}.tgz
RUN cd /opt/apache-jmeter-${JMETER_VERSION}/lib/ext && wget https://github.com/mderevyankoaqa/jmeter-influxdb2-listener-plugin/releases/download/v${JMETER_INFLUXDB_PLUGIN_VERSION}/jmeter-plugins-influxdb2-listener-${JMETER_INFLUXDB_PLUGIN_VERSION}.jar
CMD rm -rf /jmeter/result/* && cd /jmeter/plan \
    && for entry in *; do planfile=$entry;break; done \
    && jmeter -n ${PARAMS} -Dlog4j2.formatMsgNoLookups=true -t /jmeter/plan/${planfile} -l /jmeter/result/load-test-result.jtl -e -o /jmeter/result -j /log/sc-job-jmeter.log