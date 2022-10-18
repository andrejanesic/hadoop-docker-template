# Hadoop Temperatures

This is a sample project, part of my learning how to set up a Hadoop environment and Hadoop (Java/Maven) project from scratch.

[**Andreja Nesic**](https://www.linkedin.com/in/andreja-nesic/) | _Comp Sci Undergrad_ <br>
[School of Computing, Belgrade](https://www.linkedin.com/school/racunarski-fakultet/) <br>
office@andrejanesic.com <br>
anesic3119rn@raf.rs

---

Some of the code used in this repo is copyright of Copyright © 2015 Tom White, from the book "Hadoop: The Definitive Guide" (4th edition.) This code is only used for educational/learning purposes. Original code can be found here: <br>
https://github.com/tomwhite/hadoop-book

The code is also based on a fork of the [big-data-europe/docker-hadoop](https://github.com/big-data-europe/docker-hadoop) repository, which can be found here: <br>
https://github.com/big-data-europe/docker-hadoop

---

## Quick Start

To deploy an example HDFS cluster, run:
```
  docker-compose up
```

Run example app job:
```
  make app
```

Or deploy in swarm:
```
docker stack deploy -c docker-compose-v3.yml hadoop
```

`docker-compose` creates a docker network that can be found by running `docker network list`, e.g. `dockerhadoop_default`.

Run `docker network inspect` on the network (e.g. `dockerhadoop_default`) to find the IP the hadoop interfaces are published on. Access these interfaces with the following URLs:

* Namenode: http://<dockerhadoop_IP_address>:9870/dfshealth.html#tab-overview
* History server: http://<dockerhadoop_IP_address>:8188/applicationhistory
* Datanode: http://<dockerhadoop_IP_address>:9864/
* Nodemanager: http://<dockerhadoop_IP_address>:8042/node
* Resource manager: http://<dockerhadoop_IP_address>:8088/

## Configure Environment Variables

The configuration parameters can be specified in the hadoop.env file or as environmental variables for specific services (e.g. namenode, datanode etc.):
```
  CORE_CONF_fs_defaultFS=hdfs://namenode:8020
```

CORE_CONF corresponds to core-site.xml. fs_defaultFS=hdfs://namenode:8020 will be transformed into:
```
  <property><name>fs.defaultFS</name><value>hdfs://namenode:8020</value></property>
```
To define dash inside a configuration parameter, use triple underscore, such as YARN_CONF_yarn_log___aggregation___enable=true (yarn-site.xml):
```
  <property><name>yarn.log-aggregation-enable</name><value>true</value></property>
```

The available configurations are:
* /etc/hadoop/core-site.xml CORE_CONF
* /etc/hadoop/hdfs-site.xml HDFS_CONF
* /etc/hadoop/yarn-site.xml YARN_CONF
* /etc/hadoop/httpfs-site.xml HTTPFS_CONF
* /etc/hadoop/kms-site.xml KMS_CONF
* /etc/hadoop/mapred-site.xml  MAPRED_CONF

If you need to extend some other configuration file, refer to base/entrypoint.sh bash script.
