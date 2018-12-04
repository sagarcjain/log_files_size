#!/bin/bash

LOGS_DIR=${1}
EXCLUDE_LOGS=${2}
CRITICAL_SIZE=${3}

SIZE=$(du -sm ${LOGS_DIR} --exclude=${EXCLUDE_LOGS}  2> /dev/null | awk {'print $1}' | sort -rn | awk 'FNR == 1 {print}')

if [ $SIZE -lt $CRITICAL_SIZE ]; then
  echo "OK"
  exit 0
elif [ $SIZE -ge $CRITICAL_SIZE ]; then
  echo "CRITICAL - Login to instance and check if application is healthy"
  exit 2
else
  echo "UNKNOWN"
  exit 3
fi

