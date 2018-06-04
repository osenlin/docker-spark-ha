#!/bin/bash

SPARK_ENV_SH="$SPARK_CONF_DIR/spark-env.sh"

## mv spark-env.sh and spark-defaults.conf from /tmp to $SPARK_CONF_DIR
mv /tmp/spark-env.sh_worker $SPARK_ENV_SH
mv /tmp/spark-defaults.conf $SPARK_CONF_DIR/
rm /tmp/spark*

## init spark-env.sh
#sed -i "s#%java_home%#$JAVA_HOME#g" $SPARK_ENV_SH
#sed -i "s/%spark_master_host%/$SPARK_MASTER_HOST/g" $SPARK_ENV_SH
#sed -i "s/%spark_master_port%/$SPARK_MASTER_PORT/g" $SPARK_ENV_SH
#sed -i "s/%spark_worker_webui_port%/$SPARK_WORKER_WEBUI_PORT/g" $SPARK_ENV_SH
#sed -i "s/%spark_worker_cores%/$SPARK_WORKER_CORES/g" $SPARK_ENV_SH
#sed -i "s/%spark_worker_memory%/$SPARK_WORKER_MEMORY/g" $SPARK_ENV_SH
#sed -i "s/%spark_worker_daemon_memory%/$SPARK_WORKER_DAEMON_MEMORY/g" $SPARK_ENV_SH
#echo "set $SPARK_ENV_SH info: [
#    java_home->$JAVA_HOME
#    spark_master_host->$SPARK_MASTER_HOST
#    spark_master_port->$SPARK_MASTER_PORT
#    spark_worker_webui_port->$SPARK_WORKER_WEBUI_PORT
#    spark_worker_cores->$SPARK_WORKER_CORES
#    spark_worker_memory->$SPARK_WORKER_MEMORY
#    spark_worker_daemon_memory->$SPARK_WORKER_DAEMON_MEMORY
#]"

## init spark-defaults.conf
SPARK_DEFAULTS_CONF="$SPARK_CONF_DIR/spark-defaults.conf"
sed -i "s/%spark_master_host%/$SPARK_MASTER_HOST_PRE/g" $SPARK_DEFAULTS_CONF
sed -i "s/%spark_master_port%/$SPARK_MASTER_PORT/g" $SPARK_DEFAULTS_CONF
echo "set $SPARK_DEFAULTS_CONF info: [ spark_master->$SPARK_MASTER_HOST, spark_master_port->$SPARK_MASTER_PORT ]"
