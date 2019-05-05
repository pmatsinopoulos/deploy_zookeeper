#!/usr/bin/env bash


#!/usr/bin/env bash

# TODO: NEED TO CHECK/VALIDATE THE ARGUMENTS

source $(pwd)/.env

source $1

NODE_ID=$2

# Include functions used by script
# ---------------------------------
INCLUDES_DIR="$(dirname "$0")/includes"

. "$INCLUDES_DIR/update-hiera-zookeeper-servers-yaml.sh"
# --- end of including functions used by script ---

STACK_NAME="${ZOOKEEPER_NODE_STACK_NAME}-${NODE_ID}"

# I need to remove node from the puppet things and push to remote
# ---------------------------------------------------------------
FULLY_QUALIFIED_DOMAIN_NAME=$(echo ${STACK_NAME} | tr [:upper:] [:lower:]).${DOMAIN_NAME}
FILE_WITH_DATA_FOR_ZOOKEEPER_CONFIG="${HIERA_DIRECTORY_WITH_ZOOKEEPER_HOSTS_DATA}/${FULLY_QUALIFIED_DOMAIN_NAME}.yaml"
rm ${FILE_WITH_DATA_FOR_ZOOKEEPER_CONFIG}

# I need to update the zookeeper server inside hiera database
# -----------------------------------------------------------
update_hiera_zookeeper_servers_yaml
# --- end of updating the zookeeper servers inside hiera database

aws cloudformation delete-stack --stack-name ${STACK_NAME}
aws cloudformation wait stack-delete-complete --stack-name ${STACK_NAME}
