# Bundles

## Overview

This repository contains bundles which the Helm Broker uses. It allows you to choose a set of bundles and configure the Helm Broker. You can also define your own bundles.

## Usage

The `bundles` folder contains sources of bundles and index files. These files are available in [releases](https://github.com/kyma-project/bundles/releases). To learn more about the release process, read [this](docs/releasing.md) document.

If you want to configure the Helm Broker to use different set of bundles, read the [Helm Broker configuration](https://github.com/kyma-project/kyma/blob/master/docs/service-brokers/docs/011-configuration-helm-broker.md) and configure the proper URL.
 
## Development 
 
Develop your own remote `bundles` repository forked from the original repository. Read [this](docs/getting-started.md) document to learn how. On your fork, you can create your own bundles with a structure described in the [Helm Broker bundles](https://github.com/kyma-project/kyma/blob/master/docs/service-brokers/docs/012-configuration-helm-broker-bundles.md) document. Read also the [`CONTRIBUTING.md`](CONTRIBUTING.md) document that includes the contributing rules specific for this repository.

### Project structure

The repository has the following structure:

```
  ├── .github                     # Pull request and issue templates             
  ├── bundles                     # Sources of bundles                                                
  ├── docs                        # Documentation source files
  └── scripts                     # Scripts and tools which check and create bundles
```
