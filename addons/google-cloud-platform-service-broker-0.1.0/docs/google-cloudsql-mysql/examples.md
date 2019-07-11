---
title: Examples
type: Details
---

### HA Instance

An HA setup for MySQL with failover replica
Uses plan: `7d8f9ade-30c1-4c96-b622-ea0205cc5f0b`.

**Provision**

```json
{
    "backups_enabled": "true",
    "binlog": "true",
    "failover_replica_suffix": "-failover"
}
```

**Bind**

```json
{
    "role": "cloudsql.editor"
}
```

### Development Sandbox

An inexpensive MySQL sandbox for developing with no backups.
Uses plan: `7d8f9ade-30c1-4c96-b622-ea0205cc5f0b`.

**Provision**

```json
{
    "backups_enabled": "false",
    "binlog": "false",
    "disk_size": "10"
}
```

**Bind**

```json
{
    "role": "cloudsql.editor"
}
```
