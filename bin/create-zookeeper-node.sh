#!/usr/bin/env bash

# We need to create a stack with the zookeeper nodes.

# TODO: NEED TO CHECK/VALIDATE THE ARGUMENTS

source $(pwd)/.env

CONFIGURATION_FILE=$1
source ${CONFIGURATION_FILE}

NODE_ID=$2

STACK_NAME="${ZOOKEEPER_NODE_STACK_NAME}-${NODE_ID}"

aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body file://${ZOOKEEPER_NODE_CLOUD_FORMATION_FILE} \
--parameters \
ParameterKey=Ec2LaunchTemplateName,ParameterValue=${EC2_LAUNCH_TEMPLATE_NAME} \
ParameterKey=SubnetId,ParameterValue="${VPC_STACK_NAME}-Subnet${NODE_ID}" \
ParameterKey=InstanceType,ParameterValue=${ZOOKEEPER_NODE_INSTANCE_TYPE} \
ParameterKey=NodeName,ParameterValue=${STACK_NAME} \
ParameterKey=SecurityGroupName,ParameterValue="${VPC_STACK_NAME}-SecurityGroup"

aws cloudformation wait stack-create-complete --stack-name ${STACK_NAME}

