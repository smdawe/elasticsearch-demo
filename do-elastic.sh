#! /bin/bash

echo Pulling elasticsearch
docker pull docker.elastic.co/elasticsearch/elasticsearch:7.10.0

echo Start elasticsearch
docker compose up -d

echo Wait For Container To Start
sleep 15

echo Curl elasticsearch

curl "localhost:9200"

echo Create An Index
curl -X PUT "localhost:9200/example" -H 'Content-Type: application/json' -d @index.json

echo
echo Index Some Data
curl -X POST "localhost:9200/example/_doc?refresh=true" -H 'Content-Type: application/json' -d @data.json

echo
echo Index Some More Data
curl -X POST "localhost:9200/example/_doc?refresh=true" -H 'Content-Type: application/json' -d @more-data.json

echo
echo GET All Data
curl -X GET "localhost:9200/example/_search"

echo
echo Query Data
curl -X POST "localhost:9200/example/_search" -H 'Content-Type: application/json' -d @query-data.json

echo
echo Aggregate Data
curl -X POST "localhost:9200/example/_search" -H 'Content-Type: application/json' -d @aggregate-data.json

docker compose down
