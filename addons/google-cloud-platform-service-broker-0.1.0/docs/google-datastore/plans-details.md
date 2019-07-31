---
title: Details
type: Details
---

## Plans

The following plans are built-in to the GCP Service Broker and may be overriden
or disabled by the broker administrator.

  * **default**: Datastore default plan. Plan ID: `05f1fb6b-b5f0-48a2-9c2b-a5f236507a97`.


## Provisioning

**Request Parameters**

 * `namespace` _string_ - A context for the identifiers in your entity’s dataset. This ensures that different systems can all interpret an entity's data the same way, based on the rules for the entity’s particular namespace. Blank means the default namespace will be used. Default: ``.
    * The string must have at most 100 characters.
    * The string must match the regular expression `^[A-Za-z0-9_-]*$`.


## Binding

**Request Parameters**

_No parameters supported._

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
 * `namespace` _string_ - A context for the identifiers in your entity’s dataset.
    * The string must have at most 100 characters.
    * The string must match the regular expression `^[A-Za-z0-9_-]*$`.
