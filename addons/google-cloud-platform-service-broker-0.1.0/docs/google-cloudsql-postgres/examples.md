---
title: Examples
type: Details
---

### Dedicated Machine Sandbox

A low end PostgreSQL sandbox that uses a dedicated machine.
Uses plan: `c4e68ab5-34ca-4d02-857d-3e6b3ab079a7`.

**Provision**

```json
{
    "backups_enabled": "false",
    "binlog": "false",
    "disk_size": "25"
}
```

**Bind**

```json
{
    "role": "cloudsql.editor"
}
```

### Development Sandbox


An inexpensive PostgreSQL sandbox for developing with no backups.
Uses plan: `2513d4d9-684b-4c3c-add4-6404969006de`.

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