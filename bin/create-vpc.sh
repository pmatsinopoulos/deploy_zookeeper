#!/usr/bin/env bash

source $(pwd)/.env

CONFIGURATION_FILE=$1
source ${CONFIGURATION_FILE}

aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body file://${CLOUD_FORMATION_FILE} \
--parameters \
ParameterKey=Environment,ParameterValue=${ENVIRONMENT} \
ParameterKey=Ec2LaunchTemplateName,ParameterValue=${EC2_LAUNCH_TEMPLATE_NAME}

aws cloudformation wait stack-create-complete --stack-name ${STACK_NAME}
