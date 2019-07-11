---
title: Examples
type: Details
---

### Basic Configuration

Create a sandbox environment with a database admin account.
Uses plan: `44828436-cfbd-47ae-b4bc-48854564347b`.

**Provision**

```json
{
    "name": "auth-database"
}
```

**Bind**

```json
{
    "role": "spanner.databaseAdmin"
}
```

### 99.999% availability

Create a spanner instance spanning North America.
Uses plan: `44828436-cfbd-47ae-b4bc-48854564347b`.

**Provision**

```json
{
    "location": "nam3",
    "name": "auth-database"
}
```

**Bind**

```json
{
    "role": "spanner.databaseAdmin"
}
```
