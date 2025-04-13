---
layout: home
title: Головна
coverImage: /assets/images/header.jpeg
---

# {{ site.title }}

{{ site.description }}

## Публікації

{% for post in site.posts %}
- [{{ post.title }}]({{ post.url | relative_url }}) - {% include ukrainian_date.html date=post.date %}
{% endfor %}