#!/bin/bash
FLUME_CONF=${FLUME_CONF:-$FLUME_CONF_DIR/flume.conf}
OPTS="-Dorg.apache.flume.log.printconfig=true -Dlog4j.configuration=file:${LOG4J_PROPERTIES}"
if [ $MEMORY_SIZE ];
then
        OPTS="${OPTS} -Xmx${MEMORY_SIZE}"
fi

if [ $FLUME_CONF_URL ];
then
        FLUME_REMOTE_CONF="/flume_remote.conf"
        wget -qO ${FLUME_REMOTE_CONF} ${FLUME_CONF_URL}
        sed -i "s|{{AWS_ACCESS_KEY_ID}}|${AWS_ACCESS_KEY_ID}|g" ${FLUME_REMOTE_CONF}
        sed -i "s|{{AWS_SECRET_ACCESS_KEY}}|${AWS_SECRET_ACCESS_KEY}|g" ${FLUME_REMOTE_CONF}
        sed -i "s|{{S3_BUCKET}}|${S3_BUCKET}|g" ${FLUME_REMOTE_CONF}
        OPTS="${OPTS} -f ${FLUME_REMOTE_CONF}"
else
        OPTS="${OPTS} -f ${FLUME_CONF}"
fi

find /tmp/hadoop-root/s3a/ -type f -name "output-*.tmp" -delete

exec flume-ng agent -c ${FLUME_CONF_DIR} -n ${FLUME_AGENT_NAME} ${OPTS} ${@}
