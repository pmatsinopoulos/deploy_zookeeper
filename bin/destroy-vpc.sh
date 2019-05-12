#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ];then
  echo "You need to give the zookeepers configuration file as argument to the script " >&2
  exit 1
fi

source $(pwd)/.env

CONFIGURATION_FILE=$1
source ${CONFIGURATION_FILE}

aws cloudformation delete-stack --stack-name ${VPC_STACK_NAME}
aws cloudformation wait stack-delete-complete --stack-name ${VPC_STACK_NAME}
