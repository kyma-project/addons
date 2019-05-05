---
title: Overview
type: Overview
---

>**NOTE:** To provision this class, first you must create a Secret. Read the following document to learn how.

The [AWS Service Broker](https://github.com/awslabs/aws-servicebroker/blob/v1.0.0/docs) class exposes the [Amazon Web Services](https://aws.amazon.com/) from a given S3 bucket in a given Namespace of the Kyma cluster.

The AWS Service Broker uses the DynamoDB to keep the broker's state.

## Prerequisites

To install AWS Service Broker you must set up the IAM User and DynamoDB table on AWS. This can be done easily using a CloudFormation template. Use the following script to set up the prerequisites:

```bash
REGION=us-east-1
# Download the template
wget https://raw.githubusercontent.com/awslabs/aws-servicebroker/v1.0.0/setup/prerequisites.yaml
# Create stack
STACK_ID=$(aws cloudformation create-stack \
             --capabilities CAPABILITY_IAM \
             --template-body file://prerequisites.yaml \
             --stack-name  aws-service-broker-prerequisites \
             --output text --query "StackId" \
             --region ${REGION})
# Wait for stack to complete
until \
    ST=$(aws cloudformation describe-stacks \
        --region ${REGION} \
        --stack-name ${STACK_ID} \
        --query "Stacks[0].StackStatus" \
        --output text); \
        echo $ST; echo $ST | grep "CREATE_COMPLETE"
    do sleep 5
done
# Get the username from the stack outputs
USERNAME=$(aws cloudformation describe-stacks \
             --region ${REGION} \
             --stack-name ${STACK_ID} \
             --query "Stacks[0].Outputs[0].OutputValue" \
             --output text)
# Create IAM access key. Note down the output, we'll need it when setting up the broker
aws iam create-access-key \
    --user-name ${USERNAME} \
    --output json \
    --query 'AccessKey.{KEY_ID:AccessKeyId,SECRET_ACCESS_KEY:SecretAccessKey}'
```
>**NOTE:** Be sure to set the REGION variable to the AWS region where you would like to provision services.

The above script should return the following output:

```
{
    "KEY_ID": "*********",
    "SECRET_ACCESS_KEY": "***********"
}
```

Use **KEY_ID** and **SECRET_ACCESS_KEY** to create a secret with the name **aws-broker-data** in the broker's namespace:

```
apiVersion: v1
kind: Secret
metadata:
  name: aws-broker-data
  namespace: {broker namespace}
type: Opaque
data:
  accesskeyid: KEY_ID b64encoded
  secretkey: SECRET_ACCESS_KEY b64encoded
```
>**NOTE:** You must create secret with **access key ID** and **secret access key** encoded via base64.

For more detailed information about the AWS Service Broker prerequisites read this [document](https://github.com/awslabs/aws-servicebroker/blob/v1.0.0/docs/install_prereqs.md).

>**NOTE:** You can provision only one instance of the AWS Service Broker in each Namespace.