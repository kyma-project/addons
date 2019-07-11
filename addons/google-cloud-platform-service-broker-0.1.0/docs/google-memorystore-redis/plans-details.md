---
title: Details
type: Details
---

## Plans

The following plans are built-in to the GCP Service Broker and may be overriden
or disabled by the broker administrator.

  * **basic**: Provides a standalone Redis instance. Use this tier for applications that require a simple Redis cache. Plan ID: `dd1923b6-ac26-4697-83d6-b3a0c05c2c94`.
  * **standard_ha**: Provides a highly available Redis instance that includes automatically enabled cross-zone replication and automatic failover. Use this tier for applications that require high availability for a Redis instance. Plan ID: `41771881-b456-4940-9081-34b6424744c6`.


## Provisioning

**Request Parameters**

 * `authorized_network` _string_ - Optional. The full name of the Google Compute Engine network to which the instance is connected. Default: ``.
 * `memory_size_gb` _string_ - The Redis instance's provisioned capacity in GB. See: https://cloud.google.com/memorystore/pricing for more information. Default: `4`.
    * The string must have at most 10 characters.
    * The string must have at least 1 characters.
    * The string must match the regular expression `[1-9][0-9]*`.
 * `instance_id` _string_ - The name of the Redis instance. Default: `gsb-${counter.next()}-${time.nano()}`.
    * The string must have at most 40 characters.
    * The string must have at least 1 characters.
    * The string must match the regular expression `^[a-z]([-0-9a-z]*[a-z0-9]$)*`.
 * `region` _string_ - The region in which to provision the Redis instance. See: https://cloud.google.com/memorystore/docs/redis/regions for supported regions. Default: `us-east1`.
    * Examples: [us-central1 europe-west2 asia-northeast1 australia-southeast1].
    * The string must match the regular expression `^[a-z]+[-][a-z0-9]+$`.
 * `display_name` _string_ - The human-readable display name of the Redis instance. Default: `${instance_id}`.
    * The string must have at most 30 characters.
    * The string must have at least 4 characters.


## Binding

**Request Parameters**

 * `role` _string_ - The role for the account without the "roles/" prefix. See: https://cloud.google.com/iam/docs/understanding-roles for more details. Default: `redis.viewer`.
    * The value must be one of: [redis.editor redis.viewer].

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
 * `redis_version` _string_ - **Required** The version of Redis software.
 * `host` _string_ - **Required** Hostname or IP address of the exposed Redis endpoint used by clients to connect to the service.
 * `port` _string_ - **Required** The port number of the exposed Redis endpoint.
 * `memory_size_gb` _integer_ - **Required** Redis memory size in GiB.
