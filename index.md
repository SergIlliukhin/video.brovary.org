---
layout: home
title: Головна
coverImage: /assets/images/header.jpeg
---

# {{ site.title }}

{{ site.description }}

## Публікації

{% for post in site.posts limit:3 %}
- [{{ post.title }}]({{ post.url | relative_url }}) - {{ post.date | date: "%B %d, %Y" }}
{% endfor %}