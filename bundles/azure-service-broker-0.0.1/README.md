## Overview

The Azure Service Broker bundle installs the [Open Service Broker for Azure](https://github.com/Azure/open-service-broker-azure) in a given Namespace.

## Details

The Azure Service Broker bundle contains one `default` plan.  
Bundle requires secret with Azure credentals to each namespace where bundle will be provisioned. For more information about generate secret see [documentation](https://github.com/kyma-project/kyma/blob/master/docs/service-brokers/helm-broker-service-classes/azure-broker/docs/overview.md).
For more information about the provisioning and deprovisioning flow, see the ServiceClass [plan details](https://github.com/kyma-project/kyma/blob/master/docs/service-brokers/helm-broker-service-classes/azure-broker/docs/plans-details.md) documentation. 

## Bundle requirements

The Azure Service Broker bundle require sub-chart redis. Redis credential as password are generated in parent chart and inject to sub-chart redis by `secret` resource name.
Injection is made only if `redisPasswordFromParent` parameter in parent chart `values.yaml` is set to `true` otherwise redis password is generated in redis sub-chart `secret` resource. 

## Additional template files ##

According to original `open-service-broker-azure` chart, bundle `azure-service-broker` has additional files: 
* `post-install-job.yaml` - check if `ServiceBroker` resource is ready to use, if job is done `ServiceInstance` can be in running state.
* `pre-delete-job.yaml` - remove `ServiceBroker` before `Secret` resource will be removed otherwise `Secret` could be removed before `ServiceBroker` and deprovisioning process can fail.
* `sa.yaml`, `role-binding.yaml`, `role.yaml` - add permissions for jobs above.
