## Overview

The AWS Service Broker addon installs the [Open Service Broker for AWS](https://github.com/awslabs/aws-servicebroker) in a given Namespace.

## Details

The AWS Service Broker addon contains two plans - `default` and `customizable`. The addon requires a Secret with AWS credentials to each Namespace where the addon will be provisioned. 

For more information about generating a Secret, read [this](docs/overview.md) document.
For more information about the provisioning and deprovisioning flow, see the ServiceClass [plan details](docs/plans-details.md) document. 

### Additional template files

Comparing to the original `AWS Service Broker` chart, the `aws-service-broker` addon contains these additional files: 
* `docs-check-job.yaml` which checks if all deployed DocsTopics are in the READY state.
* `broker-check-job.yaml` which checks if the Service Broker resource is ready to use. After the job is finished, the Service Instance changes its state to **Running**.
* `pre-delete-job.yaml` which removes a Service Broker before a Secret resource is removed. Otherwise, the Secret can be removed before the Service Broker, in which case the deprovisioning process fails.
* `jobs-sa.yaml` which adds permissions for the preceding jobs.
* `docs.yaml` which contains DocsTopics definitions that provide documentation into the Kyma Console.
