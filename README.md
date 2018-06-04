## spark standalone ha 集群

基于rancher构建spark standalone集群，包含3个service：master、worker和client，其中client是用于提交作业的客户端。
并使用zookeeper做了master ha

#### 使用前提

hive元数据库和hdfs集群对应的stack/service已经搭建完毕。

#### 配置方法

需要以下配置：

- `stack_name`：当前stack的名字，默认`spark`，**注：一定要和当前stack名一致**

master相关配置：

- `master_port`：指定master端口，默认`17077`
- `master_webui_port`：指定master web界面的端口，默认`18080`
- `master_daemon_memory`：指定master进程的内存，默认`1g`

worker相关配置：

- `worker_scale`：指定worker个数，默认`2`
- `worker_webui_port`：指定worker web界面的端口，默认`18081`
- `worker_daemon_memory`：指定worker进程的内存，默认`1g`
- `worker_cores`：指定worker可分配的core个数，默认`4`
- `worker_memory`：指定worker可分配的内存大小，默认`2g`

client相关配置：

- `client_number`：提交作业的client的个数，默认`1`
- `client_sshd_port`：sshd端口，默认`1022`（暂时没用）
- `client_app_port`：client运行作业的端口，默认`14040`
- `hdfs_stack_name`：依赖的hdfs的stack名，默认`hdfs`
- `hdfs_name_service`：依赖的hdfs的service名，默认`finogeeks`
- `hdfs_repli_count`：hdfs的副本个数，默认`2`
- `hive_metastore_server_stack`：hive metastore server的stack名，默认`hive`
- `hive_metastore_server_port`：hive metastore server的端口，默认`10000`

#### client使用

默认会生成提交作业模板`/opt/bin/submit.sh_template`，可以根据模板和[spark官方文档](https://spark.apache.org/docs/latest/submitting-applications.html)进行个性化定制。

#### 相关说明

client的配置依赖于hdfs和hive metaStore server对应的配置生成策略，因此，需要根据hdfs和hive的配置变化而变化。

此catalog用于搭建spark standalone集群，依赖于`hiveMetaStoreServer`和`hdfs`。

#### 注意

- 默认hdfs副本数为2，生产环境中建议调整为3
- 默认hiveMetaStoreServer的配置只有一个server，生产环境中建议至少配置2个
- 暴露端口
  - master：17077（提交作业）、18080（web ui）
  - worker：18081（web ui）
  - Client：1022（sshd）、14040（web ui）


#### 参考文章

[spark standalone配置](http://spark.apache.org/docs/latest/spark-standalone.html)

[hive metastore server配置](https://cwiki.apache.org/confluence/display/Hive/AdminManual+MetastoreAdmin)