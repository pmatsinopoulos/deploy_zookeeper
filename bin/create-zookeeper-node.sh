#!/usr/bin/env bash

# We need to create a stack with the zookeeper nodes.

# TODO: NEED TO CHECK/VALIDATE THE ARGUMENTS

source $(pwd)/.env

CONFIGURATION_FILE=$1
source ${CONFIGURATION_FILE}

NODE_ID=$2

SUBNET_ID=$3



# Include functions used by script
# ---------------------------------
INCLUDES_DIR="$(dirname "$0")/includes"

. "$INCLUDES_DIR/update-hiera-zookeeper-servers-yaml.sh"
# --- end of including functions used by script ---


STACK_NAME="${ZOOKEEPER_NODE_STACK_NAME}-${NODE_ID}"
FULLY_QUALIFIED_DOMAIN_NAME=$(echo ${STACK_NAME} | tr [:upper:] [:lower:]).${DOMAIN_NAME}

FILE_WITH_DATA_FOR_ZOOKEEPER_CONFIG="${HIERA_DIRECTORY_WITH_ZOOKEEPER_HOSTS_DATA}/${FULLY_QUALIFIED_DOMAIN_NAME}.yaml"

# Update the zookeeper-hosts YAML files
# --------------------------------------
cat << EOF > ${FILE_WITH_DATA_FOR_ZOOKEEPER_CONFIG}
---
zookeeper::id: '${NODE_ID}'

EOF

# Update the common.yaml file to have the correct servers
# --------------------------------------------------------
update_hiera_zookeeper_servers_yaml

git add ${HIERA_DIRECTORY_WITH_DATA}
git commit -m "Created file ${FILE_WITH_DATA_FOR_ZOOKEEPER_CONFIG} and updated the ${SERVERS_FILE} file"
git push origin master

aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body file://${ZOOKEEPER_NODE_CLOUD_FORMATION_FILE} \
--parameters \
ParameterKey=Ec2LaunchTemplateName,ParameterValue=${EC2_LAUNCH_TEMPLATE_NAME} \
ParameterKey=SubnetId,ParameterValue="${VPC_STACK_NAME}-Subnet${SUBNET_ID}" \
ParameterKey=InstanceType,ParameterValue=${ZOOKEEPER_NODE_INSTANCE_TYPE} \
ParameterKey=NodeName,ParameterValue=${STACK_NAME} \
ParameterKey=SecurityGroupName,ParameterValue="${VPC_STACK_NAME}-SecurityGroup" \
ParameterKey=SecurityGroupNameForElectionAndLeaderPorts,ParameterValue="${VPC_STACK_NAME}-SecurityGroupZookeepersElectionAndLeaderPorts" \
ParameterKey=SecurityGroupNameForClientPort,ParameterValue="${VPC_STACK_NAME}-SecurityGroupZookeepersClientPort" \
ParameterKey=Route53PrivateHostedZoneName,ParameterValue="${DOMAIN_NAME}"

aws cloudformation wait stack-create-complete --stack-name ${STACK_NAME}

