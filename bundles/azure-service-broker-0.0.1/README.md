## Overview

The Azure Service Broker bundle installs the [Open Service Broker for Azure](https://github.com/Azure/open-service-broker-azure) in a given Namespace.

## Details

The Azure Service Broker bundle contains one `default` plan.  
The bundle requires a Secret with Azure credentials to each Namespace where the bundle will be provisioned. For more information about generating a Secret, see [this](https://github.com/kyma-project/kyma/blob/master/docs/service-brokers/helm-broker-service-classes/azure-broker/docs/overview.md) documentation.
For more information about the provisioning and deprovisioning flow, see the ServiceClass [plan details](https://github.com/kyma-project/kyma/blob/master/docs/service-brokers/helm-broker-service-classes/azure-broker/docs/plans-details.md) documentation. 

### Bundle requirements

The Azure Service Broker bundle requires the `redis` sub-chart. Redis credentials, such as password, are generated in the parent chart and are injected to the `redis` sub-chart as **secret** resource name.
The injection is possible only if the **redisPasswordFromParent** parameter in the `values.yaml` parent chart is set to `true`. Otherwise, the Redis password is generated in the `redis` sub-chart **secret** resource. 

### Additional template files

Comparing to the original `open-service-broker-azure` chart, the `azure-service-broker` bundle contains these additional files: 
* `post-install-job.yaml` - checks if the ServiceBroker resource is ready to use. After the job is finished, the ServiceInstance changes its state to **Running**.
* `pre-delete-job.yaml` - removes a ServiceBroker before a Secret resource is removed. Otherwise, the Secret can be removed before the ServiceBroker, in which case the deprovisioning process fails.
* `sa.yaml`, `role-binding.yaml`, `role.yaml` - add permissions for the preceding jobs.
