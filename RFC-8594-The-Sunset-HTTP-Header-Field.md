---
layout:      video
title:       "The Sunset HTTP Header Field"
description: "Resources and APIs disappear at some point in time; the Sunset field allows to advertise that event to clients."
---

# [RFC 8594, "The Sunset HTTP Header Field", May 2019](https://datatracker.ietf.org/doc/html/rfc8594)

When a resource or an API is about to be retired, it would be useful for consumers of that resource/API to be notified in advance. By using an HTTP field, this information can be conveyed in-band, instead of having to rely on out-of-band channels such as announcements that are published on Web pages or sent by email.

<div class="ytcontainer">
  <iframe class="yt" allowfullscreen="" src="https://www.youtube.com/embed/twfufQn1mD0"></iframe>
</div>

### Additional Resources:

- ["API Lifecycle Management: Deprecation and Sunsetting", YouTube, November 2020](https://www.youtube.com/watch?v=twfufQn1mD0)

### Short Example:

Section 3 of RFC 8594 shows a simple example of how the "Sunset" field can be used. If this header appears in an HTTP response, a consuming application can do whatever has been implemented to deal with an upcoming sunset of a resource or API.


### API Example:

In an API, the main question is scope: If an API is scheduled for sunsetting, does the field appear on all resources of the API, or only on select ones which then imply the bigger scope of the API? This policy should be clearly documented for the API so that consumers can adjust accordingly. The "implicit scope" option saves a bit of traffic, but means that generic software not knowing the implicit scope will not be able to understand that all resources of an API will disappear at the sunset time.

