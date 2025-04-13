---
layout: home
title: Головна
coverImage: /assets/images/header.jpeg
---

# {{ site.title }}

{{ site.description }}

## Публікації

{% for page in site.pages %}
{% if page.title and page.title != "Home" %}
- [{{ page.title }}]({{ page.url | relative_url }})
{% endif %}
{% endfor %} 