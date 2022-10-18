DOCKER_NETWORK = hadoop-app_default
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t bde2020/hadoop-base:$(current_branch) ./base
	docker build -t bde2020/hadoop-namenode:$(current_branch) ./namenode
	docker build -t bde2020/hadoop-datanode:$(current_branch) ./datanode
	docker build -t bde2020/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t bde2020/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t bde2020/hadoop-historyserver:$(current_branch) ./historyserver
	docker build -t bde2020/hadoop-submit:$(current_branch) ./submit

# Doesn't work!
app:
	docker build -t hadoop-app ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal -f /opt/hadoop-3.2.1/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-app
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(current_branch) hdfs dfs -rm -r /input

run:
	docker-compose up -d
	docker exec -it namenode rm -rf input
	docker exec -it namenode mkdir -p input
	docker exec -it namenode mkdir -p jars
	docker cp input/* namenode:input/
	docker cp submit/App.jar namenode:jars/
	docker exec -it namenode hadoop dfsadmin -safemode leave
	docker exec -it namenode hadoop fs -mkdir -p input
	docker exec -it namenode hdfs dfs -rmr input
	docker exec -it namenode hdfs dfs -rmr output
	docker exec -it namenode hdfs dfs -put input .
	docker exec -it namenode hadoop jar jars/App.jar input output
	docker exec -it namenode hdfs dfs -ls output/
	docker exec -it namenode hdfs dfs -cat output/part-r-00000