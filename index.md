---
layout: home
title: Головна
coverImage: /assets/images/header.jpeg
---

# {{ site.title }}

{{ site.description }}

## Публікації

{% for post in site.posts %}
- [{{ post.title }}]({{ post.url | relative_url }}) - {{ post.date | date: "%d.%m.%Y" }}
{% endfor %}

## Галерея зображень

{% assign images = site.data.wp_images %}
{% if images %}
  <div class="gallery">
    {% for image in images %}
      <div class="gallery-item">
        <img src="/assets/images/{{ image.image_name }}" alt="Image {{ image.image_id }}" class="gallery-image">
        <p>ID: {{ image.image_id }}</p>
      </div>
    {% endfor %}
  </div>
{% else %}
  <p>Зображення не знайдено</p>
{% endif %}