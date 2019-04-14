#!/usr/bin/env bash

source $(pwd)/.env

CONFIGURATION_FILE=$1
source ${CONFIGURATION_FILE}

aws cloudformation delete-stack --stack-name ${STACK_NAME}
aws cloudformation wait stack-delete-complete --stack-name ${STACK_NAME}
