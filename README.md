# Hadoop Temperatures

This is a sample project, part of my learning how to set up a Hadoop environment and Hadoop (Java/Maven) project from scratch.

[**Andreja Nesic**](https://www.linkedin.com/in/andreja-nesic/) | _Comp Sci Undergrad_ <br>
[School of Computing, Belgrade](https://www.linkedin.com/school/racunarski-fakultet/) <br>
office@andrejanesic.com <br>
anesic3119rn@raf.rs

## Setup & Running

This project requires bash in order to run the Makefile (or any equivalent of the `make` command on your system.)

1. Firstly build the required images so you can run the program:

```shell
make build
```

2. Next, build the Maven project:

```shell
mvn package
```

3. Finally, run the Docker image and program:

```shell
make run
```

## Credits

* Some of the code used in this repo is copyright of Copyright © 2015 Tom White, from the book "Hadoop: The Definitive Guide" (4th edition.) This code is only used for educational/learning purposes. Original code can be found here: <br>
https://github.com/tomwhite/hadoop-book

* The code is also based on a fork of the [big-data-europe/docker-hadoop](https://github.com/big-data-europe/docker-hadoop) repository, which can be found here: <br>
https://github.com/big-data-europe/docker-hadoop

* Patches to the original big-data-europe/docker-hadoop repository were required in order to get the Docker image working. Patches are based on the following article: <br>
https://towardsdatascience.com/hdfs-simple-docker-installation-guide-for-data-science-workflow-b3ca764fc94b