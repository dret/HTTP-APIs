---
layout:      video
title:       "Item and Collection Link Relations"
description: "Defines a pair of reciprocal link relation types that may be used to express the relationship between a collection and its members."
---

# [RFC 6573, "Item and Collection Link Relations", April 2012](https://datatracker.ietf.org/doc/html/rfc6573)

Link relation values can be used to indicate why an application would active a link or form. RFC 6573 defines two possible reasons for activating (or following) links: to reach a `collection` or to view an `item` in a collection. Response representations that include these link relation values are identifying which links return collections and which links return items from a collection.

<div class="ytcontainer">
  <iframe class="yt" allowfullscreen="" src="https://www.youtube.com/embed/TpVsg2Nz_38"></iframe>
</div>

### Additional Resources:

- [The Item and Collection Link Relations](https://webconcepts.info/specs/IETF/RFC/6573.html)
- [Link Relation: Collection](https://webconcepts.info/concepts/link-relation/collection)
- [Link Relation: Item](https://webconcepts.info/concepts/link-relation/item)

### Short Example:

Sections 2.1 (item) and 2.2 (collection) show examples of how the apply the link relation values to HTML anchor tags and HTTP Link headers. In the case of the link header field, it looks like this:


```
Link: <...>; rel="collection"; title="Return to Product Group X"
Link: <...>; rel="item"; title="View Product X001"
Link: <...>; rel="item"; title="View Product X002"
```


### API Example:

A more complete example (taken from the specification document) shows the use of the collection and item link relation values within the document body (in this case HTML):


```
<html>
  ...
    <h1>Product Group X Listing</h1>
    ...
    <a href="..." rel="collection">Return to Product Group X</a>
    
    <a href="..." rel="item">View Product X001</a>
    <a href="..." rel="item">View Product X002</a>
  ...
</html>
```

