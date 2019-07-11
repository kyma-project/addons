---
title: Examples
type: Details
---

### Basic Configuration

Create a topic and a publisher to it.
Uses plan: `622f4da3-8731-492a-af29-66a9146f8333`.

**Provision**

```json
{
    "subscription_name": "example_topic_subscription",
    "topic_name": "example_topic"
}
```

**Bind**

```json
{
    "role": "pubsub.publisher"
}
```

### No Subscription

Create a topic without a subscription.
Uses plan: `622f4da3-8731-492a-af29-66a9146f8333`.

**Provision**

```json
{
    "topic_name": "example_topic"
}
```

**Bind**

```json
{
    "role": "pubsub.publisher"
}
```

### Custom Timeout

Create a subscription with a custom deadline for long processess.
Uses plan: `622f4da3-8731-492a-af29-66a9146f8333`.

**Provision**

```json
{
    "ack_deadline": "200",
    "subscription_name": "long_deadline_subscription",
    "topic_name": "long_deadline_topic"
}
```

**Bind**

```json
{
    "role": "pubsub.publisher"
}
```
