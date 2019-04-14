#!/usr/bin/env bash

source $(pwd)/.env

source $1

aws cloudformation delete-stack --stack-name ${STACK_NAME}
aws cloudformation wait stack-delete-complete --stack-name ${STACK_NAME}
