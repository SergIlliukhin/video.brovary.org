---
layout: home
title: Home
coverImage: /assets/images/home-cover.svg
---

# {{ site.title }}

{{ site.description }}

## Recent Posts

{% for post in site.posts limit:3 %}
- [{{ post.title }}]({{ post.url | relative_url }}) - {{ post.date | date: "%B %d, %Y" }}
{% endfor %}

## Pages

{% for page in site.pages %}
{% if page.title and page.title != "Home" %}
- [{{ page.title }}]({{ page.url | relative_url }})
{% endif %}
{% endfor %} 