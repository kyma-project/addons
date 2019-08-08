# Addons

## Overview

This repository contains addons which the Helm Broker uses. For more information on what the Helm Broker is, how it uses addons, and how to create your own addons, read the official Helm Broker [documentation](https://kyma-project.io/docs/master/components/helm-broker/#overview-overview).

## Usage

The `addons` folder contains sources of addons and index files that are available in [releases](https://github.com/kyma-project/addons/releases). Choose a set of addons you want to use, add your own addons, and configure the Helm Broker to fetch them.

## Development

Develop your own addons repository forked from the original repository. Read [this](docs/getting-started.md) document to learn how. On your fork, you can create your own addons. Your addons must follow the [addons template](https://kyma-project.io/docs/master/components/helm-broker/#details-create-addons) and your addons repository must have the specified [structure](https://kyma-project.io/docs/master/components/helm-broker/#details-create-addons-repository) so that the Helm Broker can use it. Read the [`CONTRIBUTING.md`](CONTRIBUTING.md) document that includes the contributing rules specific for this repository.

>**TIP:** You can base your addon on the [`testing` addon](addons/testing-0.0.1) that uses all functionality provided by the addon specification.

### Project structure

The repository has the following structure:

```
  ├── .github                     # Pull request and issue templates    
  ├── addons                      # Sources of addons
  ├── bin                         # Tools used by Travis CI                                     
  ├── docs                        # Documentation source files
  └── scripts                     # Scripts and tools which check and create addons
```
