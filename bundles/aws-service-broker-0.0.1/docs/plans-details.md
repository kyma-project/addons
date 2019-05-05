---
title: Services and Plans
type: Details
---

## Service description

The AWS Service Broker Service Class provides the following plans:

| Plan Name | Description |
|-----------|-------------|
| `default` | Default AWS service broker plan which uses S3 bucket to store data. |

## Provision

This service provisions a new AWS Service Broker which provides the Amazon Web Services.

Default parameters provides the AWS Service Broker with default services.

### Provisioning parameters

These are the provisioning parameters:

| Parameter Name | Type | Description | Required | Default Value |
|----------------|------|-------------|----------|---------------|
| **imagePullPolicy** | `string` | Specifies how the kubelet pulls images from the specified registry. | YES | `IfNotPresent` |
| **region** | `string` | Defines the AWS region to provision services in, must match DynamoDB region. | YES | `us-east-1` |
| **s3region** | `string` | Defines the S3 bucket AWS region. | YES | `us-east-1` |
| **bucket_name** | `string` | Defines the name of the S3 bucket containing CloudFormation templates and ServiceClass specs. | YES | `awsservicebroker` |
| **broker_id** | `string` | Defines the ID of the Service Broker. | YES | `awsservicebroker` |
| **cluster_domain** | `string` | Defines the cluster domain name. | YES | `cluster.local` |
| **key** | `string` | Specifies the S3 bucket key name which contains CloudFormation templates and ServiceClass specs. | YES | `templates/latest` |
| **table_name** | `string` | Specifies the name of the table in the DynamoDB. | YES | `awssb` |
| **target_account_id** | `string` | Specifies the AWS Account ID to use. | NO |  |
| **target_role_name** | `string` | Specifies the IAM Role name to provision with, must be used in combination with target_account_id. | NO |  |
| **vpc_id** | `string` | Defines the VPC ID to use. For more information check this [documentation](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-subnets-commands-example.html). | NO |  |
| **prescribe_overrides** | `string` | Defines if the broker will use [prescribe overrides](https://github.com/awslabs/aws-servicebroker/tree/v1.0.0/docs#parameter-overrides) feature. | YES | `true` |
