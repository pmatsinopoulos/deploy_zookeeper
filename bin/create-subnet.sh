#!/usr/bin/env bash

source $(pwd)/.env

CONFIGURATION_FILE=$1
source ${CONFIGURATION_FILE}

aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body file://${CLOUD_FORMATION_FILE} \
--parameters \
ParameterKey=Environment,ParameterValue=${ENVIRONMENT} \
ParameterKey=SubnetName,ParameterValue=${SUBNET_NAME} \
ParameterKey=VpcId,ParameterValue=${VPC_ID} \
ParameterKey=AvailabilityZone,ParameterValue=${AVAILABILITY_ZONE} \
ParameterKey=CidrBlock,ParameterValue=${CIDR_BLOCK}
