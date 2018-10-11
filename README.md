# Bundles

## Overview

This repository contains bundles which the Helm Broker uses. It allows you to choose a set of bundles and configure the Helm Broker. You can also define your own bundles.

## Bundle repositories

The `bundles` folder contains subfolders with sources of complete bundle repositories. A bundle repository is available by GitHub Pages with the `https://kyma-project.github.io/bundles/{FOLDER NAME}/` URL. Any change of the `master` branch triggers CI which is taking care of updating bundle repositories. It generates necessary *.tgz files. The `bundles` repository contains the following sets of bundles (bundle repositories):
 * **stable** - the default bundle repository used in Kyma Helm Broker, accessible under the `https://kyma-project.github.io/bundles/stable/` URL
 * **showcase** - sets of bundles with Kyma show cases, accessible under the `https://kyma-project.github.io/bundles/showcase/` URL.

## Helm Broker configuration
  
If you want to configure the Helm Broker to use different set of bundles, please read the [Helm Broker configuration](https://github.com/kyma-project/kyma/blob/master/docs/service-brokers/docs/011-configuration-helm-broker.md) and configure proper URL.
 
## Development 
 
Develop on your own remote repository forked from the original repository described in [to be done] and create your own bundles with a structure described in [Helm Broker bundles](https://github.com/kyma-project/kyma/blob/master/docs/service-brokers/docs/012-configuration-helm-broker-bundles.md). Read also the [`CONTRIBUTING.md`](CONTRIBUTING.md) document that includes the contributing rules specific for this repository.

## Project structure

The repository has the following structure:

```
  ├── .github                     # Pull request and issue templates             
  ├── bundles                     # Source of bundles                                                
  ├── docs                        # Documentation source files
  └── scripts                     # Scripts and tools which checks and creates bundles
```