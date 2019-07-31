---
title: Examples
type: Details
---

### Basic Configuration

Create a nearline bucket with a service account that can create/read/list/delete the objects in it.
Uses plan: `a42c1182-d1a0-4d40-82c1-28220518b360`.

**Provision**

```json
{
    "location": "us"
}
```

**Bind**

```json
{
    "role": "storage.objectAdmin"
}
```

### Cold Storage

Create a coldline bucket with a service account that can create/read/list/delete the objects in it.
Uses plan: `c8538397-8f15-45e3-a229-8bb349c3a98f`.

**Provision**

```json
{
    "location": "us"
}
```

**Bind**

```json
{
    "role": "storage.objectAdmin"
}
```

### Regional Storage

Create a regional bucket with a service account that can create/read/list/delete the objects in it.
Uses plan: `5e6161d2-0202-48be-80c4-1006cce19b9d`.

**Provision**

```json
{
    "location": "us-west1"
}
```

**Bind**

```json
{
    "role": "storage.objectAdmin"
}
```

### Multi-Regional Storage

Create a multi-regional bucket with a service account that can create/read/list/delete the objects in it.
Uses plan: `a5e8dfb5-e5ec-472a-8d36-33afcaff2fdb`.

**Provision**

```json
{
    "location": "us"
}
```

**Bind**

```json
{
    "role": "storage.objectAdmin"
}
```

### Delete even if not empty

Sets the label sb-force-delete=true on the bucket. The broker will try to erase all contents before deleting the bucket.
Uses plan: `5e6161d2-0202-48be-80c4-1006cce19b9d`.

**Provision**

```json
{
    "force_delete": "true",
    "location": "us-west1"
}
```

**Bind**

```json
{
    "role": "storage.objectAdmin"
}
```