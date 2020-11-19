#!/bin/bash

DOMAIN=${DOMAIN:-'europe'}
NODE=${NODE:-'fmippn-1'}

#List latest file in domain folder
LATEST_TIMESTAMP=`ls -t /data/input/$DOMAIN/ | head -n1 | awk -F "_" '{print $1}'`

TIMESTAMP=${TIMESTAMP:-${LATEST_TIMESTAMP}}

echo "Calculating PPN nowcast for domain "$DOMAIN", timestamp "$TIMESTAMP

# Build from Dockerfile
#podman build --tag fmippn .

# Get configs pystepsrc and config.json from Github
#wget https://raw.githubusercontent.com/fmidev/fmippn-oper/master/fmippn/config/$DOMAIN.json
#wget https://raw.githubusercontent.com/fmidev/fmippn-oper/master/fmippn/pystepsrc
#wget https://raw.githubusercontent.com/fmidev/fmippn-oper/master/environment.yml

# Run with volume mounts
podman run \
       --rm \
       --env "timestamp=$TIMESTAMP" \
       --env "domain=$DOMAIN" \
       --mount type=bind,source=/data/input/$DOMAIN,target=/input \
       --mount type=bind,source=/data/output/$DOMAIN/$NODE,target=/output \
       --mount type=bind,source=/data/log/$NODE,target=/log \
       --mount type=bind,source="$(pwd)"/pystepsrc,target=/fmippn-oper/fmippn/pystepsrc \
       --mount type=bind,source="$(pwd)"/$DOMAIN.json,target=/fmippn-oper/fmippn/config/$DOMAIN.json \
       --security-opt label=disable \
       fmippn:latest
