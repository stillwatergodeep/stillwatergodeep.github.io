---
 layout:      post
 title:      "jekyll read more "
 subtitle:   
 date:       2015-06-28 14:00:44
 author:     "stillwater"
 description: "Adding support for <!-- more --> tag to Jekyll without plugins"
---



###Adding support for <!-- more --> tag to Jekyll without plugins

Here's a quick tip for an approach I've started using to split post content at a given point for displaying in an archive page, without using a plugin.

Until recently the approach I took to creating a snippet of a post for my archive page just trimming the post.content to 300 characters in the following way:


This worked well at first, but when I wrote posts that had very little text before a block of code at the start of the post, the post snippets didn't look very good:
<img src="https://blog.omgmog.net/images/by%20default%202013-08-23%20at%2015.33.41.png"/>
There are plugins to allow you to specify where to cut off the content for an excerpt, such as 
<a href="https://gist.github.com/stympy/986665">this plugin.</a>

But that won't work as Jekyll runs with safe: true on GitHub Pages.

So a solution... Well, Jekyll supports the liquid filters split and first, so we can do the following:

    {{ post.content | spli t"<!-- more -->" | first | strip_html | truncate:300 }}
    {&#37; if post.content | size > 300 &#37;}
        <strong>Read more</strong>
    {&#37; endif &#37;}
  

And then if we include a <!-- more --> in our post at the point that we want to split, we'll get the post to cut off the content at that point.

<img src="https://blog.omgmog.net/images/by%20default%202013-08-23%20at%2015.45.23.png"/>

So how does it work?

The split filter

The first step is to split the content at the <!-- more --> marker using the split filter. When we use split filter, it turns out post.content in to an array with two (or more) parts.
    
    {&#37; post.content | split:"<!-- more -->" &#37;}
    

So we go from:
    
    post.content =>
    
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur libero nibh, semper quis libero sed, molestie molestie nulla.
    
    <!-- more -->
    
    In in augue enim. Aenean fringilla accumsan augue, at convallis quam consequat nec."
    
Then the second step is to use the first filter to just select the part of post.content that came before the <!-- more --> marker:
    
    {&#37; post.content | split:"<!-- more -->" | first &#37;}
    
Which gives us:
    
    post.content =>
    
    ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur libero nibh, semper quis libero sed, molestie molestie nulla."]

I also take the steps to strip_html and trim the text to 300 characters.

Update: You can use Jekyll's built in "excerpt" feature these days, by doing the following:

Define your excerpt_separator in your _config.yml: excerpt_separator: "<!-- more -->"
Update the examples I provided before, to use post.excerpt:

    {&#37;post.excerpt &#37;}

