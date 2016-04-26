---
title: "A Quick Note Regarding MathJax and Jekyll"
author: "Patrick Wynne"
layout: post
date: "April 24, 2016"
output: html_document
published: true
status: publish
draft: false
output: html_document
tags: Text Mining
---

Gaston Sanchex was a short [blog post](http://gastonsanchez.com/opinion/2014/02/16/Mathjax-with-jekyll/) outlining how to get started writing LaTeX-like math equations in your jekyll blog. 

One quick not I had was where Gaston suggested added the lines 

{% highlight r %}
<script type="text/javascript"
    src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
{% endhighlight %}

to the ```page.html``` file in the ```_layouts``` folder, I instead had to add it to my```meat.html```  in my  ```_includes``` file. I'm not sure if that's specific to how my repository is composed or if it's due to different markdown engines. Either way happy to writing beautiful math equations in the blog.

$$\mathsf{Y_{ij}} = \mathsf{\alpha} + \mathsf{\alpha_{1}} + \mathsf{\alpha_{2}}+ \theta(Treat_{i}*Post_{i}) + \beta*X_{i} + Z_{j} + \epsilon_{ij}$$ 