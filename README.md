# Addons

## Overview

This repository contains addons which the Helm Broker uses. For more information on what the Helm Broker is, how it uses addons, and how to create your own addons, read the official Helm Broker [documentation](https://kyma-project.io/docs/master/components/helm-broker/#overview-overview).

## Usage

The `addons` folder contains sources of addons and index files that are available in [releases](https://github.com/kyma-project/addons/releases). Using addons, you can install the following Service Brokers:
* [Azure Service Broker](https://kyma-project.io/docs/master/components/service-catalog/#service-brokers-azure-service-broker)
* [AWS Service Broker](https://kyma-project.io/docs/master/components/service-catalog/#service-brokers-aws-service-broker)
* [Google Cloud Platform Service Broker](https://kyma-project.io/docs/master/components/service-catalog/#service-brokers-google-cloud-platform-service-broker) (preview)

You can also try out the [`testing` addon](addons/testing-0.0.1) that uses all functionality provided by the addon specification.

## Development

Develop your own addons repository forked from the original repository. Read [this](docs/getting-started.md) document to learn how. On your fork, you can create your own addons. Note that your addons must follow the [addons template](https://kyma-project.io/docs/master/components/helm-broker/#details-create-addons), and that your addons repository must have the specified [structure](https://kyma-project.io/docs/master/components/helm-broker/#details-create-addons-repository) so that the Helm Broker can use it. Read the [`CONTRIBUTING.md`](CONTRIBUTING.md) document that includes the contributing rules specific for this repository.

### Project structure

The repository has the following structure:

```
  ├── .github                     # Pull request and issue templates    
  ├── addons                      # Sources of addons
  ├── bin                         # Tools used by Travis CI                                     
  ├── docs                        # Documentation source files
  └── scripts                     # Scripts and tools which check and create addons
```
