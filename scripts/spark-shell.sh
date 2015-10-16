#!/usr/bin/env bash
/spark/remove_alias.sh # problems with hostname alias, see https://issues.apache.org/jira/browse/SPARK-6680
cd /usr/local/spark
./bin/spark-shell \
	--master spark://${SPARK_MASTER_IP}:${SPARK_MASTER_PORT}  \
	-i ${SPARK_LOCAL_IP} \
	--properties-file /spark/spark-defaults.conf \
	"$@" 
