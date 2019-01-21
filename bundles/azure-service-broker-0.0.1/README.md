## Overview

The Azure Service Broker bundle installs the [Open Service Broker for Azure](https://github.com/Azure/open-service-broker-azure) in a given Namespace.

## Details

The Azure Service Broker bundle contains one `default` plan.  

## Bundle requirements

The Azure Service Broker bundle require sub-chart redis. Redis credential as password are generated in parent chart and inject to sub-chart redis by `secret` resource name.
Injection is made only if `redisPasswordFromParent` parameter in parent chart `values.yaml` is set to `true` otherwise redis password is generated in redis sub-chart `secret` resource. 