---
title: Examples
type: Details
---

### Basic Production Configuration

Create an HDD production table and account that can manage and query the data.
Uses plan: `65a49268-2c73-481e-80f3-9fde5bd5a654`.

**Provision**

```json
{
    "name": "orders-table"
}
```

**Bind**

```json
{
    "role": "bigtable.user"
}
```
