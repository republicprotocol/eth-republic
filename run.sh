#!/bin/bash
set -e

cleanup ()
{
  kill -s SIGTERM $!
  exit 0
}

trap cleanup SIGINT SIGTERM

yarn docker-ganache &
PROC_ID=$!
sleep 5
NETWORK=localnet yarn run deploy

kill -TERM $PROC_ID