---
title: Details
type: Details
---

## Plans

The following plans are built-in to the GCP Service Broker and may be overriden
or disabled by the broker administrator.

  * **standard**: Standard storage class. Auto-selects either regional or multi-regional based on the location. Plan ID: `e1d11f65-da66-46ad-977c-6d56513baf43`.
  * **nearline**: Nearline storage class. Plan ID: `a42c1182-d1a0-4d40-82c1-28220518b360`.
  * **reduced-availability**: Durable Reduced Availability storage class. Plan ID: `1a1f4fe6-1904-44d0-838c-4c87a9490a6b`.
  * **coldline**: Google Cloud Storage Coldline is a very-low-cost, highly durable storage service for data archiving, online backup, and disaster recovery. Plan ID: `c8538397-8f15-45e3-a229-8bb349c3a98f`.
  * **regional**: Data is stored in a narrow geographic region, redundant across availability zones with a 99.99% typical monthly availability. Plan ID: `5e6161d2-0202-48be-80c4-1006cce19b9d`.
  * **multiregional**: Data is stored geo-redundantly with >99.99% typical monthly availability. Plan ID: `a5e8dfb5-e5ec-472a-8d36-33afcaff2fdb`.


## Provisioning

**Request Parameters**

 * `name` _string_ - The name of the bucket. There is a single global namespace shared by all buckets so it MUST be unique. Default: `pcf_sb_${counter.next()}_${time.nano()}`.
    * The string must have at most 222 characters.
    * The string must have at least 3 characters.
    * The string must match the regular expression `^[A-Za-z0-9_\.]+$`.
 * `location` _string_ - The location of the bucket. Object data for objects in the bucket resides in physical storage within this region. See: https://cloud.google.com/storage/docs/bucket-locations Default: `US`.
    * Examples: [US EU southamerica-east1].
    * The string must match the regular expression `^[A-Za-z][-a-z0-9A-Z]+$`.
 * `force_delete` _string_ - Attempt to erase bucket contents before deleting bucket on deprovision. Default: `false`.
    * The value must be one of: [true false].


## Binding

**Request Parameters**

 * `role` _string_ - The role for the account without the "roles/" prefix. See: https://cloud.google.com/iam/docs/understanding-roles for more details. Default: `storage.objectAdmin`.
    * The value must be one of: [storage.objectAdmin storage.objectCreator storage.objectViewer].

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
 * `bucket_name` _string_ - **Required** Name of the bucket this binding is for.
    * The string must have at most 222 characters.
    * The string must have at least 3 characters.
    * The string must match the regular expression `^[A-Za-z0-9_\.]+$`.
