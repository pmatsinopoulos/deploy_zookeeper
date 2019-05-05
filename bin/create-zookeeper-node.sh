#!/usr/bin/env bash

# We need to create a stack with the zookeeper nodes.

# TODO: NEED TO CHECK/VALIDATE THE ARGUMENTS

source $(pwd)/.env

CONFIGURATION_FILE=$1
source ${CONFIGURATION_FILE}

NODE_ID=$2

STACK_NAME="${ZOOKEEPER_NODE_STACK_NAME}-${NODE_ID}"
FULLY_QUALIFIED_DOMAIN_NAME=$(echo ${STACK_NAME} | tr [:upper:] [:lower:]).${DOMAIN_NAME}

DIRECTORY_WITH_DATA=puppet/data
DIRECTORY_WITH_ZOOKEEPER_HOSTS_DATA=${DIRECTORY_WITH_DATA}/zookeeper-hosts
FILE_WITH_DATA_FOR_ZOOKEEPER_CONFIG="${DIRECTORY_WITH_ZOOKEEPER_HOSTS_DATA}/${FULLY_QUALIFIED_DOMAIN_NAME}.yaml"
SERVERS_FILE=${DIRECTORY_WITH_DATA}/zookeeper-servers.yaml

# Update the zookeeper-hosts YAML files
# --------------------------------------
cat << EOF > ${FILE_WITH_DATA_FOR_ZOOKEEPER_CONFIG}
---
zookeeper::id: '${NODE_ID}'

EOF

# Update the common.yaml file to have the correct servers
# --------------------------------------------------------
NUMBER_OF_SERVERS=$(ls -l ${DIRECTORY_WITH_ZOOKEEPER_HOSTS_DATA}/*.yaml | wc -l)

cat << EOF > ${SERVERS_FILE}
---
zookeeper::servers:
EOF

for ((i=1; i<=${NUMBER_OF_SERVERS};i++)); do

NAME_FOR_NODE="${ZOOKEEPER_NODE_STACK_NAME}-${i}"
NAME_FOR_NODE=$(echo ${NAME_FOR_NODE} | tr [:upper:] [:lower:]).${DOMAIN_NAME}

cat << EOF >> ${SERVERS_FILE}
  - '${NAME_FOR_NODE}'
EOF

done

git add ${DIRECTORY_WITH_DATA}
git commit -m "Created file ${FILE_WITH_DATA_FOR_ZOOKEEPER_CONFIG} and updated the ${SERVERS_FILE} file"
git push origin master

aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body file://${ZOOKEEPER_NODE_CLOUD_FORMATION_FILE} \
--parameters \
ParameterKey=Ec2LaunchTemplateName,ParameterValue=${EC2_LAUNCH_TEMPLATE_NAME} \
ParameterKey=SubnetId,ParameterValue="${VPC_STACK_NAME}-Subnet${NODE_ID}" \
ParameterKey=InstanceType,ParameterValue=${ZOOKEEPER_NODE_INSTANCE_TYPE} \
ParameterKey=NodeName,ParameterValue=${STACK_NAME} \
ParameterKey=SecurityGroupName,ParameterValue="${VPC_STACK_NAME}-SecurityGroup" \
ParameterKey=SecurityGroupNameForElectionAndLeaderPorts,ParameterValue="${VPC_STACK_NAME}-SecurityGroupZookeepersElectionAndLeaderPorts" \
ParameterKey=SecurityGroupNameForClientPort,ParameterValue="${VPC_STACK_NAME}-SecurityGroupZookeepersClientPort" \
ParameterKey=Route53PrivateHostedZoneName,ParameterValue="${DOMAIN_NAME}"

aws cloudformation wait stack-create-complete --stack-name ${STACK_NAME}

