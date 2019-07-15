# Prow Integration

This document describes `addons` integration with [Prow](https://github.com/kubernetes/test-infra/tree/master/prow).

### Repository integration with Prow

The [Makefile](../Makefile) defines the build steps described in [this](releases.md) document.
Use this Makefile to change the integration implementation for the `addons` repository.

### Prow configuration

Find the Prow configuration for the `addons` project in the [test-infra](https://github.com/kyma-project/test-infra/blob/master/prow/jobs/addons/addons.yaml) repository.
