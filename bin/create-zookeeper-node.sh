#!/usr/bin/env bash

set -e

source $(pwd)/.env

# Include functions used by script
# ---------------------------------
INCLUDES_DIR="$(dirname "$0")/includes"

. "$INCLUDES_DIR/update-hiera-zookeeper-servers-yaml.sh"
. "$INCLUDES_DIR/display-usage-information.sh"
# --- end of including functions used by script ---

if [ "$#" -ne 3 ];then
  display_usage_information_for_creating_zookeeper_node
  exit 1
fi

CONFIGURATION_FILE=$1
source ${CONFIGURATION_FILE}

NODE_ID=$2

SUBNET_ID=$3

if ((${SUBNET_ID} < 1 || ${SUBNET_ID} > 3)); then
  echo "ERROR: Wrong Subnet index!" >&2
  display_usage_information_for_creating_zookeeper_node
  exit 1
fi

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

GIT_REPOSITORY=deploy_zookeeper
# Convert git ssh access to git https access.
REMOTE_URL=$(git ls-remote --get-url origin)
if [[ ${REMOTE_URL} =~ ^git ]]; then
    GIT_USERNAME=$(echo ${REMOTE_URL} | cut -d':' -f2 | cut -d'/' -f1)
    GIT_HTTPS_URL="https://github.com/${GIT_USERNAME}/${GIT_REPOSITORY}.git"
else
    GIT_HTTPS_URL=${REMOTE_URL}
fi

aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body file://${ZOOKEEPER_NODE_CLOUD_FORMATION_FILE} \
--parameters \
ParameterKey=GitRemoteRepositoryUrl,ParameterValue=${GIT_HTTPS_URL} \
ParameterKey=Ec2LaunchTemplateName,ParameterValue=${EC2_LAUNCH_TEMPLATE_NAME} \
ParameterKey=SubnetId,ParameterValue="${VPC_STACK_NAME}-Subnet${SUBNET_ID}" \
ParameterKey=InstanceType,ParameterValue=${ZOOKEEPER_NODE_INSTANCE_TYPE} \
ParameterKey=NodeName,ParameterValue=${STACK_NAME} \
ParameterKey=SecurityGroupName,ParameterValue="${VPC_STACK_NAME}-SecurityGroup" \
ParameterKey=SecurityGroupNameForElectionAndLeaderPorts,ParameterValue="${VPC_STACK_NAME}-SecurityGroupZookeepersElectionAndLeaderPorts" \
ParameterKey=SecurityGroupNameForClientPort,ParameterValue="${VPC_STACK_NAME}-SecurityGroupZookeepersClientPort" \
ParameterKey=Route53PrivateHostedZoneName,ParameterValue="${DOMAIN_NAME}"

echo "Waiting for stack to be created..."
aws cloudformation wait stack-create-complete --stack-name ${STACK_NAME}

