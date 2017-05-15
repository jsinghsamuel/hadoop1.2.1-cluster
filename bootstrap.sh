#!/bin/bash

: ${HADOOP_PREFIX:=/usr/hadoop}

service ssh start

su - hduser -c ". ~/.bashrc"

$HADOOP_PREFIX/conf/hadoop-env.sh

if [[ $1 == "-d" ]]; then
	while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
	/bin/bash
fi
