#!/bin/bash

cassandra_load () {
  ./bin/ycsb.sh load cassandra-cql -P "workloads/$1"  -p hosts="$3" -threads "$2" -s
}

cassandra_run () {
  ./bin/ycsb.sh run cassandra-cql -P "workloads/$1"  -p operationcount=10000000 -p hosts="$3" -p maxexecutiontime=300 -threads "$2" -p cassandra.readconsistencylevel="QUORUM" -p cassandra.writeconsistencylevel="QUORUM" -s |& tee "out/cassandra/"$1-$2-`date +%Y%m%d-%H%M%S`.log
}

cockroach_load () {
  urls=seed,$3
  ./bin/ycsb.sh load jdbc -P "workloads/$1" -p db.driver=org.postgresql.Driver -p db.url="$(for x in $(echo $urls | sed "s/,/ /g"); do printf "jdbc:postgresql://$x:26257/ycsb;"; done)" -p db.user=root -p db.batchsize=1000 -p jdbc.autocommit=true -threads "$2" -s
}


cockroach_run () {
  urls=seed,$3
  [[ $# = 4 ]] && auto=$4 || auto=false
  ./bin/ycsb.sh run jdbc -P "workloads/$1" -p operationcount=10000000 -p db.driver=org.postgresql.Driver -p db.url="$(for x in $(echo $urls | sed "s/,/ /g"); do printf "jdbc:postgresql://$x:26257/ycsb;"; done)" -p db.user=root -p jdbc.autocommit=$auto -p maxexecutiontime=300 -threads "$2" -s |& tee "out/cockroach/"$1-$2-$auto-`date +%Y%m%d-%H%M%S`.log
}
