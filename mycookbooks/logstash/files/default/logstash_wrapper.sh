#!/bin/bash
export JAVA_HOME=/etc/java-config-2/current-system-vm
CLASSPATH=/data/logstash/logstash-1.1.9-monolithic.jar
CONFIG=/data/logstash/filter.conf

case $1 in
start)
    echo $$ > /var/run/logstash.pid;
    exec java -jar $CLASSPATH agent -f $CONFIG --log /data/logstash/logstash.log 
    ;;
stop)
    kill `cat /var/run/logstash.pid` ;;
*)
echo "usage: logstash {start|stop}" ;;
esac
exit 0

