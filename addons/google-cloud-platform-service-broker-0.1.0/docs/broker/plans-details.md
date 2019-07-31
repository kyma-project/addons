---
title: Details
type: Details
---

## Service description

The `GCP Service Broker` service provides the following plan names and descriptions:

| Plan Name | Description |
|-----------|-------------|
| `Default` | Installs the Google Cloud Platform (GCP) Service Broker in a default configuration. |

## Provisioning parameters

These are the provisioning parameters for the `Default` plan:


| Parameter Name | Display Name | Type | Description | Required | Default Value |
|----------------|---------|-----|-------------|:----------:|---------------|
| **secretName** | `GCP Secret name` | `string` | Defines the name of the Secret from which the Service Broker will try to fetch credentials. | YES |  |

## Binding

Binding to this Service Class is disabled.

## Deprovisioning

Deprovisioning uninstalls the GCP Service Broker and unregisters it from the Service Catalog.

