#!/bin/bash

DATA_OUTPUT_LIMIT=32

cd `dirname $0`
stdbuf -oL ./ws-data-xchg-server -o$DATA_OUTPUT_LIMIT >> ./server.log

