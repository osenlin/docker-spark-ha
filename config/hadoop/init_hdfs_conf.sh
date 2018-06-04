#!/bin/bash

CORE_SITE_XML="$SPARK_CONF_DIR/core-site.xml"
mv /tmp/core-site.xml $CORE_SITE_XML

sed -i "s/%hdfs_nameservice%/$HDFS_NAME_SERVICE/g" $CORE_SITE_XML
echo "set hdfs info [ defaultFs->$HDFS_NAME_SERVICE ] in $CORE_SITE_XML"


HDFS_SITE_XML="$SPARK_CONF_DIR/hdfs-site.xml"
mv /tmp/hdfs-site.xml $HDFS_SITE_XML

sed -i "s/%hdfs_nameservice%/$HDFS_NAME_SERVICE/g" $HDFS_SITE_XML
sed -i "s/%hdfs_stackname%/$HDFS_STACK_NAME/g" $HDFS_SITE_XML
sed -i "s/%hdfs_replication%/$HDFS_REPLI_COUNT/g" $HDFS_SITE_XML
echo "set hdfs info [ nameservice->$HDFS_NAME_SERVICE, nn1&nn2 name prefix->$HDFS_STACK_NAME, replic count->$HDFS_REPLI_COUNT ] in $HDFS_SITE_XML"

echo "--------------init hdfs config finished--------------"
