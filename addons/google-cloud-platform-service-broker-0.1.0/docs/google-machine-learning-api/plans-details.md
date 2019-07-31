---
title: Details
type: Details
---

## Plans

The following plans are built-in to the GCP Service Broker and may be overriden
or disabled by the broker administrator.

  * **default**: Machine Learning API default plan. Plan ID: `be7954e1-ecfb-4936-a0b6-db35e6424c7a`.


## Provisioning

**Request Parameters**

_No parameters supported._


## Binding

**Request Parameters**

 * `role` _string_ - The role for the account without the "roles/" prefix. See: https://cloud.google.com/iam/docs/understanding-roles for more details. Default: `ml.modelUser`.
    * The value must be one of: [ml.developer ml.jobOwner ml.modelOwner ml.modelUser ml.operationOwner ml.viewer].

**Response Parameters**

 * `Email` _string_ - **Required** Email address of the service account.
    * Examples: [pcf-binding-ex312029@my-project.iam.gserviceaccount.com].
    * The string must match the regular expression `^pcf-binding-[a-z0-9-]+@.+\.gserviceaccount\.com$`.
 * `Name` _string_ - **Required** The name of the service account.
    * Examples: [pcf-binding-ex312029].
 * `PrivateKeyData` _string_ - **Required** Service account private key data. Base64 encoded JSON.
    * The string must have at least 512 characters.
    * The string must match the regular expression `^[A-Za-z0-9+/]*=*$`.
 * `ProjectId` _string_ - **Required** ID of the project that owns the service account.
    * Examples: [my-project].
    * The string must have at most 30 characters.
    * The string must have at least 6 characters.
    * The string must match the regular expression `^[a-z0-9-]+$`.
 * `UniqueId` _string_ - **Required** Unique and stable ID of the service account.
    * Examples: [112447814736626230844].
