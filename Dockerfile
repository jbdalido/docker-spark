FROM java:7

ENV DEBIAN_FRONTEND noninteractive 
ENV ES_HADOOP_VERSION 2.1.1

RUN apt-get update -y \
    && apt-get install curl \
    && curl -s http://apache.crihan.fr/dist/spark/spark-1.5.1/spark-1.5.1-bin-hadoop2.6.tgz \
    | tar -xz -C /usr/local/ \
    && ln -s /usr/local/spark-1.5.1-bin-hadoop2.6 /usr/local/spark

RUN wget http://download.elastic.co/hadoop/elasticsearch-hadoop-${ES_HADOOP_VERSION}.zip && \
    unzip elasticsearch-hadoop-${ES_HADOOP_VERSION}.zip && \
    mv elasticsearch-hadoop-${ES_HADOOP_VERSION}/dist/*.jar /usr/local/spark/lib && \
    rm -rf elasticsearch-hadoop-${ES_HADOOP_VERSION}*

COPY scripts/ /spark

ENV PATH $PATH:/spark
ENV SPARK_HOME /usr/local/spark
ENV SPARK_MASTER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"
ENV SPARK_WORKER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"

ENV SPARK_MASTER_IP   spark-master
ENV SPARK_MASTER_PORT 7077
ENV SPARK_LOCAL_IP 127.0.0.1
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_WORKER_PORT 8888
ENV SPARK_WORKER_WEBUI_PORT 8081

EXPOSE 8080 7077 8888 8081 4040 7001 7002 7003 7004 7005 7006 
