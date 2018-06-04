#!/bin/bash

PWD="$(cd "`dirname "$0"`"; pwd)"

## init spark conf
sh $PWD/init_master_conf.sh

echo "spark.ui.port             $SPARK_UI_PORT" >> $SPARK_CONF_DIR/spark-defaults.conf
echo "add \"spark.ui.port             $SPARK_UI_PORT\" to $SPARK_CONF_DIR/spark-defaults.conf"

## init hdfs/hive conf
sh $PWD/init_hive_conf.sh
sh $PWD/init_hdfs_conf.sh

## init submit job template script
cat << EOF > /opt/bin/submit.sh_template
#!/bin/bash

export SPARK_HOME=$SPARK_HOME

\$SPARK_HOME/bin/spark-submit \\
--class main-class \\
--deploy-mode client/cluster \\
--executor-memory 1g \\
--total-executor-cores 2 \\
--conf k=v \\
application.jar \\
arguments
EOF
