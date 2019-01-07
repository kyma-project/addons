# Testing

## Overview

The `Testing` bundle is a simple bundle which contains a ConfigMap and a Deployment. It is a showcase on how to define a chart with minimal and full configuration.

## Details

The bundle contains the following plans:
- Minimal, a plan which is not bindable and contains only necessary parameters.
- Full, which contains all possible parameters.

Binding returns one value with the ConfigMap name.
