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

According to original `open-service-broker-azure` chart, bundle `azure-service-broker` has additional files: 
* `post-install-job.yaml` - check if `ServiceBroker` resource is ready to use, if job is done `ServiceInstance` can be in running state.
* `pre-delete-job.yaml` - remove `ServiceBroker` before `Secret` resource will be removed otherwise `Secret` could be removed before `ServiceBroker` and deprovisioning process can fail.
* `sa.yaml`, `role-binding.yaml`, `role.yaml` - add permissions for jobs above.
