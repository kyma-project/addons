## Overview

This document describes how to configure a forked Helm Broker bundles repository.

## Prerequisites

Before you start, install:

* [Kyma](https://kyma-project.io/docs/latest/root/kyma#getting-started-getting-started) in version v0.4.1 or later
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) in version v1.10.0 or later
* [svcat CLI](https://svc-cat.io/docs/cli/) in version v1.10.0 or later

## Steps

Follow these steps to configure your own bundles repository and to complete this Getting Started guide.

### Create a fork and enable Travis CI with the GitHub repository

1. Fork the [bundle repository](https://github.com/kyma-project/bundles).

2. Go to the [GitHub](https://github.com) page.

3. In your GitHub profile account, choose the **Settings** tab. In the left sidebar, click **Developer settings**.

4. In the left sidebar, click **Personal access tokens**.

5. Click **Generate new token**.

6. Give your token a descriptive name.

7. Select the `public_repo` scope of the token.

8. Click **Generate token** and copy your personal access token.

9. Go to [Travis CI](https://travis-ci.com/) and sign up with your GitHub account. Accept the **Authorization** of Travis CI.

10. Click the **Activate** button and select your forked bundles repository. Click the **Approve & Install** button to give Travis CI access to your forked `bundle` repository.

11. In the left sidebar, click **My Repositories** tab and choose your GitHub repository.

12. Click the **More options** tab on the right and select **Settings**.

13. Go to the **Environment Variables** section. Set **Name** as `GITHUB_TOKEN`. **Value** is equal to your GitHub personal access token. Click the **Add** button.

14. Go to the **More options** tab and select **Trigger build**. Select a master branch and click the **Trigger custom build** button.

### Create a bundle

1. Create your bundle according to the [instruction](https://kyma-project.io/docs/latest/components/service-brokers#configuration-how-to-create-a-bundle).

2. Place your bundle into the `bundles/` directory.

3. Along with your bundle directory, update `index.yaml` which defines the available bundles. Find the instruction on how to create a valid file [here](https://github.com/kyma-project/kyma/blob/master/docs/helm-broker/docs/05-01-helm-broker.md#configuring-the-helm-broker-externally).

4. Commit changes and push them to the master branch.

5. You can check the build status on [Travis CI](https://travis-ci.com/) webpage. The [Releasing](releasing.md) document describes the tagging and releasing processes.

6. Configure Helm Broker with the new repository as described [here](https://github.com/kyma-project/kyma/blob/master/docs/helm-broker/docs/05-01-helm-broker.md#configure-repository-urls-in-the-runtime).

### Check your Kyma Service Catalog

1. Go to the Kyma console in your browser.

2. Choose Environment.

3. The new bundles are visible in the **Catalog** section in the left sidebar.

4. The new bundles should appear. If not then go to the Troubleshooting section.

## Troubleshooting

Check Helm Broker Pod's logs, which can give you a lot of information about the occurred issue. To check the logs, run:

```
kubectl logs -n kyma-system -l app=helm-broker
```