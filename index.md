---
layout: home
title: Головна
coverImage: /assets/images/home-cover.svg
---

# {{ site.title }}

{{ site.description }}

## Публікації

{% for page in site.pages %}
{% if page.title and page.title != "Home" %}
- [{{ page.title }}]({{ page.url | relative_url }})
{% endif %}
{% endfor %} 