#!/bin/csh

## BOOK

setenv GRAPHS_HOME /Users/tony/Projects/graphs

## BOOK - NEO4J

setenv NEO4J_VERSION 3.5.7
setenv NEO4J_HOME ${GRAPHS_HOME}/neo4j/neo4j-community-${NEO4J_VERSION}
setenv NEO4J_CONF ${NEO4J_HOME}/conf
alias neo4j $NEO4J_HOME/bin/neo4j
alias cypher '$NEO4J_HOME/bin/cypher-shell -u neo4j -p neo4jtest'
# neo4j restart

## BOOK - GRAPHDB

setenv GRAPHDB_VERSION 8.10.1
setenv GRAPHDB_HOME ${GRAPHS_HOME}/graphdb/graphdb-free-${GRAPHDB_VERSION}
alias graphdb ${GRAPHDB_HOME}/bin/graphdb
# graphdb -d

## BOOK - GREMLIN

setenv GREMLIN_VERSION 3.4.2
setenv MY_GREMLIN_HOME ${GRAPHS_HOME}/gremlin/apache-tinkerpop-gremlin-console-${GREMLIN_VERSION}
setenv MY_GREMLIN_SERVER_HOME ${GRAPHS_HOME}/gremlin/apache-tinkerpop-gremlin-server-${GREMLIN_VERSION}
alias gremlin ${MY_GREMLIN_HOME}/bin/gremlin.sh
alias gremlin-server ${MY_GREMLIN_SERVER_HOME}/bin/gremlin-server.sh
# gremlin-server restart

## BOOK - DGRAPH

setenv MY_DGRAPH_HOME /usr/local
alias dgraph ${MY_DGRAPH_HOME}/bin/dgraph

####

neo4j restart

kill -9 `cat ${GRAPHDB_HOME}/pid.txt`
graphdb -d -p ${GRAPHDB_HOME}/pid.txt

gremlin-server restart

dgraph zero &
dgraph alpha --lru_mb 2048 --zero localhost:5080 &

####
