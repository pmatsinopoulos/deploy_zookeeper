#!/usr/bin/env bash


#!/usr/bin/env bash

# TODO: NEED TO CHECK/VALIDATE THE ARGUMENTS

source $(pwd)/.env

source $1

NODE_ID=$2

STACK_NAME="${ZOOKEEPER_NODE_STACK_NAME}-${NODE_ID}"

aws cloudformation delete-stack --stack-name ${STACK_NAME}
aws cloudformation wait stack-delete-complete --stack-name ${STACK_NAME}
