---
layout: page
title:  关于Pixyll 中文版
permalink: /about/
no\_duoshuo: true
---

## Equations
<script type="text/x-mathjax-config">
    MathJax.Hub.Config({
      jax: ["input/TeX", "output/HTML-CSS"],
      tex2jax: {
        inlineMath: [ ['$', '$'], ["\\(", "\\)"] ],
        displayMath: [ ['$$', '$$'], ["\\[", "\\]"] ],
        processEscapes: true,
        skipTags: ['script', 'noscript', 'style', 'textarea', 'pre', 'code']
      }
    });

    function addBlankTargetForLinks () {
      $('a[href^="http"]').each(function(){
        $(this).attr('target', '_blank');
      });
    }

    $(document).bind('DOMNodeInserted', function(event) {
      addBlankTargetForLinks();
    });

</script>
<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML" type="text/javascript"></script>

<script type="math/tex">
a^2+b
</script>
<br/>
\(E=mc^2\)，$$x_{1,2} = \frac{-b \pm \sqrt{b^2-4ac}}{2b}.$$