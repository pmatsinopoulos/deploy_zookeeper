#!/usr/bin/env bash

source $(pwd)/.env

STACK_NAME=$1

aws cloudformation delete-stack --stack-name ${STACK_NAME}
