---
title: Examples
type: Details
---

### Basic Configuration

Creates a datastore and a user with the permission `datastore.user`.
Uses plan: `05f1fb6b-b5f0-48a2-9c2b-a5f236507a97`.

**Provision**

```json
{}
```

**Bind**

```json
{}
```

### Custom Namespace

Creates a datastore and returns the provided namespace along with bind calls.
Uses plan: `05f1fb6b-b5f0-48a2-9c2b-a5f236507a97`.

**Provision**

```json
{
    "namespace": "my-namespace"
}
```

**Bind**

```json
{}
```