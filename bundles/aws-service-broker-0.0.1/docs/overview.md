---
title: Overview
type: Overview
---

[AWS broker](https://aws.amazon.com/partners/servicebroker/) is an open source implementation of the Open Service Broker API. On the Red Hat OpenShift platform, the Kubernetes Service Catalog provides an intermediate layer that allows users to deploy services using native manifests and the graphical UI.                        

AWS Service Broker supports a subset of AWS services, including Amazon Relational Database Service (Amazon RDS), Amazon EMR, Amazon DynamoDB, Amazon Simple Storage Service (Amazon S3), and Amazon Simple Queue Service (Amazon SQS); for a full list, see the AWS Service Broker documentation. 

The broker includes AWS CloudFormation templates that manage infrastructure, resources, and build logic. These templates contain both prescriptive and customizable parameter sets that provide best-practice implementations for production, test, and development environments. 

Applications can consume or interact with these resources by using a set of values such as endpoints and credentials. Binding allows developers to create microservices that consume AWS services without knowledge or insight into the underlying resources.

