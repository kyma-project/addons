---
title: Examples
type: Details
---

### Basic Configuration

Create a dataset and account that can manage and query the data.
Uses plan: `10ff4e72-6e84-44eb-851f-bdb38a791914`.

### Reader Writer

Creates a general Firestore user and grants it permission to read and write entities.
Uses plan: `64403af0-4413-4ef3-a813-37f0306ef498`.

**Provision**

```json
{}
```

**Bind**

```json
{}
```

### Read Only

Creates a Firestore user that can only view entities.
Uses plan: `64403af0-4413-4ef3-a813-37f0306ef498`.

**Provision**

```json
{}
```

**Bind**

```json
{
    "role": "datastore.viewer"
}
```