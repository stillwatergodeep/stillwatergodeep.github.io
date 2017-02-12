---
 layout:      post
 title:      "利用sublime快速编写markdown"
 subtitle:      
 author:      stillwater
 date:  2015-06-28 21:08:30
 description: "sublime中可以自动生成front-matter"
---


插件实现插入带时间功能的说明：

## 创建插件：

Tools → New Plugin:

{% highlight python %}
import datetime
import sublime_plugin
class addInfo(sublime_plugin.TextCommand):
    def run(self, edit):
        self.view.run_command("insert_snippet", 
            {
        "contents": "---""\n"#you have to start with contents
        " layout:      post""\n"
        " title:      ""\n"
        " subtitle:      ""\n"
        " author:      stillwater""\n"
        " dateTime:  "  "%s"  %datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S") +"\n"
        " description: Description""\n"
        "---"
            }
        )
{% endhighlight %}

保存为Sublime Text 2\Packages\User\ addInfo.py

<!-- more -->
####2. 创建快捷键：

Preference → Key Bindings - User:
<pre>
[
    {
        "command": "add_info",
        "keys": [
            "ctrl+shift+,"#注意这里我试了一些字母而非标点，貌似没有作用，有可能是因为冲突，没有细究。
        ]
    }
]
</pre>