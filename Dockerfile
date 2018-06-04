FROM docker.finogeeks.club/base/java
MAINTAINER linzhihuang "linzhihuang@finogeeks.com"

ENV SERVICE_NAME=spark \
    SPARK_HOME=/opt/spark \
    HADOOP_VERSION=2.7 \
    SPARK_VERSION=2.2.1 \
    SERVICE_USER=spark \
    SERVICE_UID=10003 \
    SERVICE_GROUP=spark \
    SERVICE_GID=10003
ENV SPARK_CONF_DIR=$SPARK_HOME/conf \
    PATH=$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH \
    SERVICE_HOME=$SPARK_HOME

WORKDIR /opt

ADD spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz /opt/
ADD config/* /tmp/
ADD config/hadoop/* /tmp/

RUN mv spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION spark \
    && mkdir /opt/bin \
    && mv /tmp/*.sh /opt/bin \
    && mv /tmp/log4j.properties $SPARK_HOME/conf/ \
    && chmod +x /opt/bin/*.sh \
    && addgroup --gid ${SERVICE_GID} ${SERVICE_GROUP} \
    && adduser --disabled-password --no-create-home --shell /sbin/nologin --home ${SERVICE_HOME} --ingroup ${SERVICE_GROUP} --uid ${SERVICE_UID} ${SERVICE_USER} \
    && chown -R ${SERVICE_USER}:${SERVICE_GROUP} /opt \
    && echo "deb http://mirrors.zju.edu.cn/kali kali-rolling main contrib non-free" > /etc/apt/sources.list \
    && echo "deb-src http://mirrors.zju.edu.cn/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get -y --allow-unauthenticated install wget \
    && chmod -R 777 /tmp

#USER $SERVICE_USER

CMD [ "sh", "-c", "/opt/bin/start.sh >> $SPARK_HOME/out.log 2>&1 && tail -f $SPARK_HOME/out.log" ]
