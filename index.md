---
layout: home
title: Головна
coverImage: /assets/images/header.jpeg
---

# {{ site.title }}

{{ site.description }}

## Публікації

{% assign categories = site.posts | map: "categories" | uniq | sort %}
{% for category in categories %}
### {{ category | capitalize }}

{% for post in site.posts %}
  {% if post.categories contains category %}
- [{{ post.title }}]({{ post.url | relative_url }}) - {% include ukrainian_date.html date=post.date %}
  {% endif %}
{% endfor %}
{% endfor %}