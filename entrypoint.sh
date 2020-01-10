#!/bin/sh

eval "$*" &

pid=$!

# creates all databases in $DATABASES seperated by :
./bin/run -i create-dbs.clj

trap "kill -s TERM ${pid}" TERM
trap "kill -s TERM ${pid}" INT
wait $pid
