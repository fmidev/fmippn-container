#!/bin/bash

DOMAIN=${DOMAIN:-'ravake_hdf5'}

#Read short hostname from server to use as output folder names.
HOSTNAME=`hostname -s`
NODE=${NODE:-${HOSTNAME}}

#List latest file in domain folder
LATEST_TIMESTAMP=`ls -t /data/input/$DOMAIN/ | head -n1 | awk -F "_" '{print $1}'`

TIMESTAMP=${TIMESTAMP:-${LATEST_TIMESTAMP}}

echo "Calculating PPN nowcast for domain "$DOMAIN", timestamp "$TIMESTAMP

# Build from Dockerfile
#podman build --tag fmippn_pysteps14 -f Dockerfile_pysteps14

# Run with volume mounts
podman run \
       --rm \
       --env "timestamp=$TIMESTAMP" \
       --env "domain=$DOMAIN" \
       --mount type=bind,source=/data/input/$DOMAIN,target=/input \
       --mount type=bind,source=/data/output/${DOMAIN}_pysteps14/$NODE,target=/output \
       --mount type=bind,source=/data/log/$NODE,target=/log \
       --mount type=bind,source="$(pwd)"/${DOMAIN}_container.json,target=/fmippn-oper/fmippn/config/$DOMAIN.json \
       --security-opt label=disable \
       fmippn_pysteps14:latest
