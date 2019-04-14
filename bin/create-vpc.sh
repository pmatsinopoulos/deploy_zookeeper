#!/usr/bin/env bash

source $(pwd)/.env

STACK_NAME=$1
CLOUD_FORMATION_FILE=$2
ENVIRONMENT=$3

aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body file://${CLOUD_FORMATION_FILE} \
--parameters ParameterKey=Environment,ParameterValue=${ENVIRONMENT}
