---
title: Overview
type: Overview
---

>**NOTE:** To provision this class, first you must create a Secret. Read the following document to learn how.

The GCP Service Broker class exposes services from the [Open Service Broker for Google Cloud Platform](https://github.com/GoogleCloudPlatform/gcp-service-broker)
in a given Namespace of the Kyma cluster.

The MySQL database is used to keep the broker's state. You can configure an external database. Uninstalling the broker deletes all information about created instances. It does not delete the services you created.

## Create a Secret

To add the GCP Service Broker to your Namespace, prepare a service account and a JSON access key.

Follow these steps to create a Kubernetes Secret which contains a JSON access key:

1. Open `https://console.cloud.google.com/` and select your project.

2. On the left pane, go to **IAM & admin** and select **Service accounts**.

3. Click **Create service account**, name your account, and click **Create**.

4. Set the `Project Owner` role.

5. Click **Create key** and choose `JSON` as a key type.

6. Save the `JSON` file.

7. Create a Secret from the JSON file by running this command:

        kubectl create secret generic gcp-broker-data --from-file=sa-key={FILENAME} --from-literal=project-name={GCP_PROJECT_ID} --namespace {NAMESPACE}

8. Click **Done**.

>**NOTE:** You can provision only one instance of the GCP Service Broker in each Namespace.
