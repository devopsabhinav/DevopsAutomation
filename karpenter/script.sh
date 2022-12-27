#!/bin/sh

# Author : Vinayak Pawar
# Monitoring-stack automation Script

 # Environment Variables 
export KARPENTER_VERSION=v0.19.3
export CLUSTER_NAME="cluster_name"
export AWS_DEFAULT_REGION="us-west-2"
export AWS_ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"

# Create the Karpenter Infrastructure and IAM Roles
curl -fsSL https://karpenter.sh/"${KARPENTER_VERSION}"/getting-started/getting-started-with-eksctl/cloudformation.yaml  > $TEMPOUT
aws cloudformation deploy --stack-name "Karpenter-${CLUSTER_NAME}" --template-file "${TEMPOUT}" --capabilities CAPABILITY_NAMED_IAM --parameter-overrides "ClusterName=${CLUSTER_NAME}"

 # Grant Access to Nodes to Join the Cluster
ekctl create iamidentitymapping --username system:node:{{EC2PrivateDNSName}} --cluster "${CLUSTER_NAME}" --arn "arn:aws:iam::${AWS_ACCOUNT_ID}:role/KarpenterNodeRole-${CLUSTER_NAME}" --group system:bootstrappers --group system:nodes
 # Create the KarpenterController IAM Role
eksctl create iamserviceaccount --cluster "${CLUSTER_NAME}" --name karpenter --namespace karpenter --role-name "${CLUSTER_NAME}-karpenter" --attach-policy-arn "arn:aws:iam::${AWS_ACCOUNT_ID}:policy/KarpenterControllerPolicy-${CLUSTER_NAME}" --role-only --approve
 # Create the KarpenterController IAM Role
export KARPENTER_IAM_ROLE_ARN="arn:aws:iam::${AWS_ACCOUNT_ID}:role/${CLUSTER_NAME}-karpenter"
 # Create the EC2 Spot Service Linked Role
aws iam create-service-linked-role --aws-service-name spot.amazonaws.com || true


 # Install Karpenter Helm Chart
helm upgrade --install karpenter oci://public.ecr.aws/karpenter/karpenter --version ${KARPENTER_VERSION} --namespace karpenter --create-namespace --set serviceAccount.annotations."eks\.amazonaws\.com/role-arn"=${KARPENTER_IAM_ROLE_ARN} --set settings.aws.clusterName=${CLUSTER_NAME} --set settings.aws.clusterEndpoint=${CLUSTER_ENDPOINT} --set settings.aws.defaultInstanceProfile=KarpenterNodeInstanceProfile-${CLUSTER_NAME} --set settings.aws.interruptionQueueName=${CLUSTER_NAME} --wait