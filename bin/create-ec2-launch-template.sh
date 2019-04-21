#!/usr/bin/env bash

source $(pwd)/.env

CONFIGURATION_FILE=$1
source ${CONFIGURATION_FILE}

LAUNCH_TEMPLATE_DATA=$(cat ${INSTANCE_TEMPLATE_DATA_FILE})

aws ec2 create-launch-template --launch-template-name ${EC2_LAUNCH_TEMPLATE_NAME} \
--launch-template-data "${LAUNCH_TEMPLATE_DATA}"
