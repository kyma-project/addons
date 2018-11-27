## Overview

This document describes `bundles` integration with [Prow](https://github.com/kubernetes/test-infra/tree/master/prow).

### Repository integration with Prow

The [Makefile](../Makefile) defines the build steps to achieve the goal described in the [Releasing](releasing.md) guide.
Use this Makefile to change the integration implementation for the `bundles` repository.

### Prow configuration repository

You can find the Prow configuration for the `bundles` project in the [test-infra](https://github.com/kyma-project/test-infra/blob/master/prow/jobs/bundles/bundles.yaml) repository.