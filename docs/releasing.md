This document describes how the release flow looks like and how to create a bundle release.

## Release process

Every change in the master branch which passes all checks triggers creating a `latest` tag and release.

Every tag pushed to the repository triggers a new release. If the tag name matches the `x.y.0` version pattern, in which `0` is revision, Travis CI build creates a release tag named `release-x.y`.

## Create a release from the master branch

Follow these steps to create a new bundle release 0.6.0:

1. Checkout the master branch with the latest changes:

    ```
    git checkout master
    git pull
    ```

2. Create a tag with the proper release version:

    ```
    git tag 0.6.0
    ```   

3. Push the tag:

    ```
    git push {remote} 0.6.0 
    ```
    
    >**NOTE:** For example, if you want to push the tag to the upstream, run the following command:
    >```
    >git push upstream 0.6.0 
    >```
    

4. After Travis CI jobs finish, go to the **releases** tab and the **branches**. There you can find a new release and a new release branch.
 
## Create a release from the release branch

Follow these steps to create a new bundle release 0.6.1:

1. Checkout a release branch with the latest changes. For example:

    ```
    git fetch {remote}
    git checkout release-0.6
    git pull
    ```

2. Create a tag with the proper release version. For example:

    ```
    git tag 0.6.1
    ```   

3. Push the tag:

    ```
    git push {remote} 0.6.1 
    ```

4. After Travis CI jobs finish, go to the **releases** tab. There you can find a new `0.6.1` release.

## Changelog functionality

Every creation of a new release generates two changelog files, one assign to specific release and one reffering to all bundles repository.

Changelog files contain list of all pull requests beetwen releases with labels defined as default for [lerna-changelog](https://github.com/lerna/lerna-changelog#usage). 
You can define your own labels in `scripts/package.json` file according to [lerna-changelog configuration](https://github.com/lerna/lerna-changelog#configuration).

>**NOTE:** If you work on your fork change `scripts/package.json` configuration file setting parameters indicating on repository: `repository.url` and `changelog.repo`