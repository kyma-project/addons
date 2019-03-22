# Prow Integration

This document describes `bundles` integration with [Prow](https://github.com/kubernetes/test-infra/tree/master/prow).

### Repository integration with Prow

The [Makefile](../Makefile) defines the build steps described in [this](releases.md) document.
Use this Makefile to change the integration implementation for the `bundles` repository.

### Prow configuration

Find the Prow configuration for the `bundles` project in the [test-infra](https://github.com/kyma-project/test-infra/blob/master/prow/jobs/bundles/bundles.yaml) repository.
