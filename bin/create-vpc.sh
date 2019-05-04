#!/usr/bin/env bash

# TODO: NEED TO CHECK/VALIDATE THE ARGUMENTS

source $(pwd)/.env

CONFIGURATION_FILE=$1
source ${CONFIGURATION_FILE}

aws cloudformation create-stack --stack-name ${VPC_STACK_NAME} --template-body file://${VPC_CLOUD_FORMATION_FILE} \
--parameters \
ParameterKey=Environment,ParameterValue=${ENVIRONMENT} \
ParameterKey=Ec2LaunchTemplateName,ParameterValue=${EC2_LAUNCH_TEMPLATE_NAME} \
ParameterKey=Route53PrivateHostedZoneName,ParameterValue=${DOMAIN_NAME}

aws cloudformation wait stack-create-complete --stack-name ${VPC_STACK_NAME}
