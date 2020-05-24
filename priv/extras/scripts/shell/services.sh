#!/bin/bash

## BOOK

export GRAPHS_HOME=/Users/tony/Projects/graphs

## BOOK - NEO4J

export NEO4J_VERSION=3.5.7
export NEO4J_HOME=${GRAPHS_HOME}/neo4j/neo4j-community-${NEO4J_VERSION}
# export NEO4J_CONF=${NEO4J_HOME}/conf
export PATH=${PATH}:$NEO4J_HOME/bin

neo4j restart

## BOOK - GRAPHDB

# export GRAPHDB_VERSION=8.10.1
export GRAPHDB_VERSION=9.2.0
export GRAPHDB_HOME=${GRAPHS_HOME}/graphdb/graphdb-free-${GRAPHDB_VERSION}
export PATH=${PATH}:$GRAPHDB_HOME/bin

kill -9 `cat ${GRAPHDB_HOME}/pid.txt`
graphdb -d -p ${GRAPHDB_HOME}/pid.txt

## BOOK - GREMLIN

export GREMLIN_VERSION=3.4.2
export GREMLIN_SERVER=apache-tinkerpop-gremlin-server-${GREMLIN_VERSION}
export GREMLIN_SERVER_HOME=${GRAPHS_HOME}/gremlin/${GREMLIN_SERVER}
export PATH=${PATH}:$GREMLIN_SERVER_HOME/bin

gremlin-server.sh restart

## BOOK - DGRAPH

export DGRAPH_HOME=${GRAPHS_HOME}/dgraph

# cur_dir=`pwd`
# cd $DGRAPH_HOME
# dgraph zero &
# dgraph alpha --lru_mb 2048 --zero localhost:5080 &
# cd $cur_dir

# docker-compose -f ${DGRAPH_HOME}/docker-compose.yml up -d 
# docker-compose -f ${DGRAPH_HOME}/docker-compose-v1.0.16.yml up -d 

###
