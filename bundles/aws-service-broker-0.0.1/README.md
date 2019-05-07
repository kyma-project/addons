## Overview

The AWS Service Broker bundle installs the [Open Service Broker for AWS](https://github.com/awslabs/aws-servicebroker) in a given Namespace.

## Details

The AWS Service Broker bundle contains two plans - `default` and `customizable`. The bundle requires a Secret with AWS credentials to each Namespace where the bundle will be provisioned. 

For more information about generating a Secret, see [this](docs/overview.md) documentation.
For more information about the provisioning and deprovisioning flow, see the ServiceClass [plan details](docs/plans-details.md) documentation. 

### Additional template files

Comparing to the original `AWS Service Broker` chart, the `aws-service-broker` bundle contains these additional files: 
* `docs-check-job.yaml` - checks if all deployed DocsTopics are in the ready state.
* `broker-check-job.yaml` - checks if the Service Broker resource is ready to use. After the job is finished, the Service Instance changes its state to **Running**.
* `pre-delete-job.yaml` - removes a Service Broker before a Secret resource is removed. Otherwise, the Secret can be removed before the Service Broker, in which case the deprovisioning process fails.
* `jobs-sa.yaml` - add permissions for the preceding jobs.
* `docs.yaml` - contains the definitions of the DocsTopics which provides documentation into the Kyma Console.
