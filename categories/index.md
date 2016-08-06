---
title: Categories
layout: default
---

<header id="post-header">
    <h1 id="post-subtitle">Categories</h1>
</header>

<div id="post-content">
    <hr />

    {% for category in site.categories %}
        {% capture category_slug %}{{ category | first }}{% endcapture %}
        {% for c_slug in category_slug %}
            {% if c_slug == page.categories %}
                <button class="btn btn-sm btn-default active">{{ c_slug }} ( {{ category[1].size }} )</button>
            {% else %}
                <a href="/category/#{{ c_slug }}" class="btn btn-sm btn-default">{{ c_slug }} ( {{ category[1].size }} )</a>
            {% endif %}
        {% endfor %}
    {% endfor %}

    <hr />

{% for category in site.categories %} 
	<h2 id="{{ category[0] }}">{{ category[0] }}</h2>
		<ul>
		{% assign pages_list = category[1] %}  
		{% for post in pages_list %}
			{% if forloop.first %}
				<div class="list-group">
			{% endif %}

			<ul class="posts">
				<li><a href="{{ post.url }}">{{ post.title }}</a> &raquo; <i><span>{{ post.date | date_to_string }}</span></i></li>
			</ul>

			{% if forloop.last %}
				</div>
			{% endif %}
		{% endfor %}
		{% assign pages_list = nil %}
		{% assign group = nil %}
		</ul>
{% endfor %}

</div>
