#!/usr/bin/env bash
/usr/local/spark/sbin/start-master.sh --properties-file /spark/spark-defaults.conf -i $SPARK_LOCAL_IP "$@"
/bin/bash
