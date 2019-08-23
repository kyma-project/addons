---
title: Details
type: Details
---

## Service description

The `GCP Service Broker` service provides the following plan names and descriptions:

| Plan Name           | Description |
|---------------------|-------------|
| `Default`           | Installs the GCP Service Broker with the default configuration. |
| `External database` | Allows to configure the external MySQL database. |

## Provisioning parameters

These are the provisioning parameters for the following plans:

`Default:`

| Parameter Name | Display Name | Type | Description | Required | Default Value |
|----------------|---------|-----|-------------|:----------:|---------------|
| **secretName** | `GCP Secret name` | `string` | Defines the name of the Secret from which the Service Broker will try to fetch credentials. | YES |  |


`External database:`

| Parameter Name          | Display Name | Type | Description | Required | Default Value |
|-------------------------|---------|-----|-------------|:----------:|---------------|
| **secretName**          | `GCP Secret name` | `string` | Defines the name of the Secret from which the Service Broker will try to fetch credentials. | YES |  |
| **mysql.host**          | `MySQL Host` | `string` | Defines the host name of the MySQL database. | YES |  |
| **mysql.port**          | `MySQL Port` | `string` | Defines the port of the MySQL database. | YES | 3306 |
| **mysql.mysqlUser**     | `MySQL Database Name` | `string` | Defines the name of the MySQL database. | YES |  |
| **mysql.mysqlPassword** | `MySQL User` | `string` | Defines the MySQL user name. | YES |  |
| **mysql.mysqlDatabase** | `MySQL Password` | `string` | Defines the MySQL user password. | YES |  |


## Binding

Binding to this Service Class is disabled.

## Deprovisioning

Deprovisioning uninstalls the GCP Service Broker and unregisters its Service Classes from the Service Catalog.

