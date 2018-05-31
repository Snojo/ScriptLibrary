#!/usr/bin/env bash

THISDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

INSTANCE_ID=$(cat ~/aws/instance-id.txt)
SECURITY_GROUP_ID=$(cat ~/aws/security-group-id.txt)
USERNAME=$(aws iam get-user --query 'User.UserName' --output text)

. ${THISDIR}/../ec2/functions.sh

if [ -e "~/aws/instance-id.txt" ]; then
    aws ec2 terminate-instances --instance-ids ${INSTANCE_ID}

    echo Waiting for instance to terminate....
    aws ec2 wait --region eu-west-1 instance-terminated --instance-ids ${INSTANCE_ID}
    echo Instance ${INSTANCE_ID} terminated

    rm ~/aws/instance-id.txt
    rm ~/aws/instance-public-name.txt
fi

JENKINS_SECURITY_GROUP=jenkins-admin

if [ ! -e ./ec2_instance/security-group-id.txt ]; then
    SECURITY_GROUP_ID=$(cat ~/aws/security-group-id.txt)
else
    delete-security-group ${JENKINS_SECURITY_GROUP}
    rm ~/aws/security-group-id.txt
fi
