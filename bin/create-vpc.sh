#!/usr/bin/env bash

source $(pwd)/.env

source $1

aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body file://${CLOUD_FORMATION_FILE} \
--parameters ParameterKey=Environment,ParameterValue=${ENVIRONMENT}
