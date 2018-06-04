#!/bin/bash

HIVE_SITE_XML="$SPARK_CONF_DIR/hive-site.xml"
mv /tmp/hive-site.xml $HIVE_SITE_XML

sed -i "s/%hive_metastore_server_stack%/$HIVE_METASTORE_SERVER_STACK/g" $HIVE_SITE_XML
sed -i "s/%hive_metastore_server_port%/$HIVE_METASTORE_SERVER_PORT/g" $HIVE_SITE_XML

echo "set $HIVE_SITE_XML info [ MetaStore Server Stack->$HIVE_METASTORE_SERVER_STACK, Port->$HIVE_METASTORE_SERVER_PORT ]"
echo "------------init hive conf finished------------"
