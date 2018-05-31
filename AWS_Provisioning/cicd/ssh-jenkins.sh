#!/usr/bin/env bash

INSTANCE_PUBLIC_NAME=$(cat ~/aws/instance-public-name.txt)
USERNAME=$(aws iam get-user --query 'User.UserName' --output text)
PEM_NAME=tempo-admin

echo "Connecting ec2-user@${INSTANCE_PUBLIC_NAME}"
ssh -i "~/aws/${PEM_NAME}.pem" centos@${INSTANCE_PUBLIC_NAME}
