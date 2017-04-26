#!/bin/sh
FLUME_CONF=${FLUME_CONF:-$FLUME_CONF_DIR/flume.conf}
MEMORY_SIZE=${MEMORY_SIZE:""}
OPTS="-Dorg.apache.flume.log.printconfig=true -Dlog4j.configuration=file:${LOG4J_PROPERTIES}"
if [ $MEMORY_SIZE ];
then
        OPTS="${OPTS} -Xmx${MEMORY_SIZE}"
fi

#TODO add FLUME_CONF_URL for downloading configuration file remotely
exec flume-ng agent -c ${FLUME_CONF_DIR} -n ${FLUME_AGENT_NAME} -f ${FLUME_CONF} ${OPTS} ${FLUME_OPTS:-$FLUME_CONF_DIR/flume.conf}
