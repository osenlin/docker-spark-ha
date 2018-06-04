#!/bin/bash

PWD="$(cd "`dirname "$0"`"; pwd)"

LOCK_FILE=/opt/init.lock

if [ "$NODE_TYPE" == "master" ]; then
  ## init master conf and start master
  if [ ! -f $LOCK_FILE ]; then
    echo "***** step1: init master conf file"
    sh $PWD/init_master_conf.sh
    touch $LOCK_FILE
  else
    echo "master conf inited before"
  fi

  echo "***** step2: start master"
  $SPARK_HOME/sbin/start-master.sh
elif [ "$NODE_TYPE" == "client" ]; then
  ## init client conf and job submit script
  if [ ! -f $LOCK_FILE ]; then
    echo "***** step1: init client conf file"
    sh $PWD/init_client_conf.sh
    touch $LOCK_FILE
  else
    echo "client conf inited before"
  fi
else
  ## init worker conf and start master
  if [ ! -f $LOCK_FILE ]; then
    echo "***** step1: init worker conf file"
    sh $PWD/init_worker_conf.sh
    touch $LOCK_FILE
  else
    echo "worker conf inited before"
  fi

  echo "***** step2: start worker"
  $SPARK_HOME/sbin/start-slave.sh spark://$SPARK_MASTER_HOST:$SPARK_MASTER_PORT
fi
