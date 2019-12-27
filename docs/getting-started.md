# Getting Started

This document describes how to configure your forked Helm Broker `addons` repository.

## Prerequisites

* [Kyma](https://kyma-project.io/docs/master/root/kyma/#installation-installation) in version v0.4.1 or higher
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) in version v1.10.0 or higher
* [svcat CLI](https://svc-cat.io/docs/cli/) in version v1.10.0 or higher

## Steps

Follow these steps to set up your addons repository with Travis CI, configure the Helm Broker to use your addons, and see them in the Service Catalog.


### Fork the repository and enable Travis CI

1. Fork the [`addons` repository](https://github.com/kyma-project/addons).

2. Generate the access token. In your GitHub profile account, choose the **Settings** tab and click **Developer settings**. Then, go to **Personal access tokens** and **Generate new token**. Give your token a descriptive name. Select the `public_repo` scope for it. Click **Generate token** and copy your personal access token.

4. Sign up to [Travis CI](https://travis-ci.com/) with your GitHub account. Accept the Travis CI authorization.

5. Enable Travis CI. Click the **Activate** button and select your forked addons repository. Click the **Approve & Install** button to give Travis CI access to your forked `addon` repository.

6. Configure Travis CI. On the left sidebar, click **My Repositories** tab and choose your GitHub repository. Click the **More options** tab on the right and select **Settings**. Go to the **Environment Variables** section. Set **Name** as `GITHUB_TOKEN`. **Value** is equal to your GitHub personal access token. Click **Add**.

7. Trigger a build. Go to the **More options** tab and select **Trigger build**. Select the master branch and click **Trigger custom build**.


### Create your addons

1. [Create your addons](https://kyma-project.io/docs/master/components/helm-broker/#details-create-addons) and place them in the `addons/` directory.

2. Update the [`index.yaml` file](https://kyma-project.io/docs/components/helm-broker#details-create-addons-repository-the-index-yaml-file) which defines the available addons.

3. Commit your changes and push them to the master branch.

4. Check the build status on [Travis CI](https://travis-ci.com/). To learn how to tag and release your addons, see [this](releases.md) document.

5. Configure the Helm Broker to [fetch addons from your repository](https://kyma-project.io/docs/master/components/helm-broker/#details-create-addons-repository).



### Check the Service Catalog in Kyma

1. Go to the Kyma console in your browser.

2. Choose the Namespace.

3. See your addons in the **Catalog** section on the left sidebar.



## Troubleshooting

Check the Helm Broker Pod's logs. They can give you a lot of information about the occurred issue. To check the logs, run:

```
kubectl logs -n kyma-system -l app=helm-broker
```
