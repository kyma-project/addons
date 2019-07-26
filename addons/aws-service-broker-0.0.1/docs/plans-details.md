---
title: Services and Plans
type: Details
---

## Service description

The AWS Service Broker Service Class provides the following plans:

| Plan Name | Description |
|-----------|-------------|
| `default` | Default AWS Service Broker plan which uses the S3 bucket to fetch Service Classes definitions. |
| `customizable` | Customizable AWS service broker plan which uses S3 bucket to fetch Service Classes definitions. Using this plan you can configure all available settings of the Service Broker. |

## Provision

This service provisions a new AWS Service Broker which provides the Amazon Web Services. The default bucket parameters provide the AWS Service Broker with default services.

### Provisioning parameters

These are the provisioning parameters for the given plans:

#### Default plan

| Parameter Name | Display Name | Type | Description | Required | Default Value |
|----------------|---------|-----|-------------|:----------:|---------------|
| **secretName** | `AWS Secret name` | `string` | Defines the name of the Secret from which the Service Broker will try to fetch credentials. | YES |  |
| **region** | `Broker region` | `string` | Defines the AWS region in which you provision your services. It must match the DynamoDB region. | YES | `us-east-1` |

#### Customizable plan

| Parameter Name | Display Name | Type | Description | Required | Default Value |
|----------------|-----|-------|-------------|:----------:|---------------|
| **imagePullPolicy** | `Image pull policy` | `string` | Specifies how the kubelet pulls images from the specified registry. | YES | `IfNotPresent` |
| **region** | `Broker region`   | `string` | Defines the AWS region in which you provision your services. It must match the DynamoDB region. | YES | `us-east-1` |
| **s3region** | `S3 Bucket region` | `string` | Defines the S3 bucket AWS region. | YES | `us-east-1` |
| **bucket** | `S3 Bucket name`  | `string` | Defines the name of the S3 bucket containing CloudFormation templates and ServiceClass specifications. | YES | `awsservicebroker` |
| **brokerid** | `Service Broker ID` | `string` | Defines the ID of the Service Broker, which is used as a prefix to store data in the DynamoDB. | YES | `awsservicebroker` |
| **clusterDomain** | `Cluster domain` | `string` | Defines the cluster domain name. | YES | `cluster.local` |
| **key** | `S3 Bucket key` | `string` | Specifies the S3 bucket key name which contains CloudFormation templates and ServiceClass specifications. | YES | `templates/latest` |
| **tablename** | `DynamoDB table name` | `string` | Specifies the name of the DynamoDB table to use by the Service Broker. | YES | `awssb` |
| **targetaccountid** | `AWS Target account ID` | `string` | Specifies the AWS account ID. | NO |  |
| **targetrolename** | `AWS Target IAM role name` | `string` | Specifies the IAM Role name to provision with. It must be used in combination with **target_account_id**. | NO |  |
| **vpcid** | `AWS VPC ID` | `string` | Defines the VPC ID to launch broker into. For more information, read [this](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-subnets-commands-example.html) documentation. | NO |  |
| **prescribeoverrides** | `Prescribe-overrides feature enabled` | `bool` | Indicates whether broker will use the [prescribe overrides](https://github.com/awslabs/aws-servicebroker/tree/v1.0.0/docs#parameter-overrides) feature. | YES | `true` |
| **secretName** | `AWS Secret name` | `string` | Defines the name of the Secret from which the Service Broker will try to fetch credentials. | YES |  |

