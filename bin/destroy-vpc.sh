#!/usr/bin/env bash

# TODO: NEED TO CHECK/VALIDATE THE ARGUMENTS

source $(pwd)/.env

source $1

aws cloudformation delete-stack --stack-name ${VPC_STACK_NAME}
aws cloudformation wait stack-delete-complete --stack-name ${VPC_STACK_NAME}
