#!/bin/bash

set -e

function usage {
    echo ""
    echo "Usage: $(basename "$0") TERRAGRUN_RUN_DIR"
    echo ""
}

function on_fail {
    echo "ERROR: $1"
    exit 1
}

function on_exit {
    exit_code=$?
    [ ${exit_code} -eq 0 ] || echo -e "\n Error: Encountered an error. See logs for details."
    exit ${exit_code}
}

trap on_exit EXIT

if [ $# -eq 0 ];then
    echo "No arguments provided"
    usage && exit 1
else
    TERRAGRUNT_DIR=$1
    TERRAGRUNT_REMOTE_DIR=${TERRAGRUNT_DIR##*/}
    SOURCE_DIR=$2
fi

echo $TERRAGRUNT_DIR $TERRAGRUNT_REMOTE_DIR $SOURCE_DIR

echo `pwd`

if [[ -d ${SOURCE_DIR}/all_accounts ]]; then
    echo "coping files from ${SOURCE_DIR}/all_accounts to ${TERRAGRUNT_DIR}"
    cp -r ${SOURCE_DIR}/all_accounts/* ${TERRAGRUNT_DIR}
else
    echo "dir ${SOURCE_DIR}/all_accounts does not exit"
    exit 1
fi
echo "Copy environment spec files"

# ENVIRONMENT=`jq -r --arg v ${TERRAGRUNT_REMOTE_DIR} '.[$v]' ${SOURCE_DIR}/env.json`
# # echo "Copying ${SOURCE_DIR}/${ENVIRONMENT}/* to ${TERRAGRUNT_DIR}"

# if [[ -d ${SOURCE_DIR}/${ENVIRONMENT} ]]; then
#     echo "Copying ${SOURCE_DIR}/${ENVIRONMENT}/* to ${TERRAGRUNT_DIR}/"
#     cp -r ${SOURCE_DIR}/${ENVIRONMENT} ${TERRAGRUNT_DIR}/ 
# else
#     echo "env ${SOURCE_DIR}/${ENVIRONMENT} does not exit"
#     exit 1
# fi
