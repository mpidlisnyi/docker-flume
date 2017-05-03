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
        OPTS="${OPTS} -f ${FLUME_REMOTE_CONF}"
else
        OPTS="${OPTS} -f ${$FLUME_CONF}"
fi

exec flume-ng agent -c ${FLUME_CONF_DIR} -n ${FLUME_AGENT_NAME} ${FLUME_CONF} ${OPTS} ${@}
