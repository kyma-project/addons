---
title: Services and Plans
type: Details
---

## Service description

The AWS service broker Service Class provides the following plans:

| Plan Name | Description |
|-----------|-------------|
| `default` | Default AWS service broker plan which uses S3 bucket to store data. |


## Provision

This service provisions a new AWS broker.

### Provisioning parameters

These are the provisioning parameters:

| Parameter Name | Type | Description | Required | Default Value |
|----------------|------|-------------|----------|---------------|
| **imagePullPolicy** | `string` | Specifies how the kubelet pulls images from the specified registry. The possible values are `Always`, `IfNotPresent`, `Never`. | NO | `IfNotPresent` |
| **brokerRegion** | `string` | Specifies the AWS service broker region. | YES | `eu-central-1` |
| **s3Region** | `string` | Specifies the S3 bucket region. | YES | `eu-central-1` |
| **clusterDomain** | `string` | Specifies the clusterDomain | YES | `cluster.local` |
