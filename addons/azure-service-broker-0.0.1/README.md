## Overview

The Azure Service Broker addon installs the [Open Service Broker for Azure](https://github.com/Azure/open-service-broker-azure) in a given Namespace.

## Details

The Azure Service Broker addon contains one `default` plan. The addon requires a Secret with Azure credentials to each Namespace where the addon will be provisioned.

For more information about generating a Secret, read [this](https://github.com/kyma-project/addons/blob/master/addons/azure-service-broker-0.0.1/docs/broker/overview.md#create-a-secret) document.
For more information about the provisioning and deprovisioning flow, see the [plans details](https://github.com/kyma-project/addons/blob/master/addons/azure-service-broker-0.0.1/docs/broker/plans-details.md) document.

### Addon requirements

The Azure Service Broker addon requires the `redis` sub-chart. Redis credentials, such as password, are generated in the parent chart and injected to the `redis` sub-chart.
By default, the **redisPasswordFromParent** parameter in the `values.yaml` parent chart is set to `true`, which means that the Redis password is generated in the parent's Secret and injected to the `redis` sub-chart.

### Additional template files

Comparing to the original `open-service-broker-azure` chart, the `azure-service-broker` addon contains these additional files:
* `post-install-job.yaml` - checks if the Service Broker resource is ready to use. After the job is finished, the Service Instance changes its state to **Running**.
* `pre-delete-job.yaml` - removes a Service Broker before a Secret resource is removed. Otherwise, the Secret can be removed before the Service Broker, in which case the deprovisioning process fails.
* `sa.yaml`, `role-binding.yaml`, `role.yaml` - add permissions for the preceding jobs.
