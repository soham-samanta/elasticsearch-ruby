#!/bin/bash

TEST_ES_SERVER=${TEST_ES_SERVER:-"http://localhost:9200"}
echo $TEST_ES_SERVER
attempt_counter=0
max_attempts=5
url="${TEST_ES_SERVER}/_cluster/health?wait_for_status=green&timeout=50s"

echo "Waiting for Elasticsearch..."
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' --min-time 60 "$url")" != "150" ]]; 
do
  if [ ${attempt_counter} -eq ${max_attempts} ];then
    echo "\nCouldn't connect to Elasticsearch"
    read -p "Enter file name : " filename
  printf '.'
  attempt_counter=$(($attempt_counter+1))
  sleep 10
done

echo "\nReady"
