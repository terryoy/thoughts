---
layout: post
title: XML/Markup解析的几种调用方式比较
tags: python
date: 2020-03-04 11:58
---

（本文只初步比较一下几个库的不同接口，并没有深入XML格式的使用场景如XML Schema、namespaces等其他相关的问题。）

要了解XML类型文档的解析，可以先看看官方的[Structure Markup Processing Tools](https://docs.python.org/3.8/library/markup.html)文档。这里提供了几种不同的解析方法，根据其调用方法的不同可能会在不同场景下试用：

* html.parser.HTMLParser - 提供一个继承
* xml （XML解析）
  * xml.etree.ElementTree - 提供ElementTree解析方式的API
  * xml.dom - 提供DOM API解析方式的API
    * xml.dom.minidom - Minimal DOM实现
    * xml.dom.pulldom - 支持构建非完整的DOM树
  * xml.sax - 提供SAX解析方式的API8

另外如果你关心XML解析的性能的话，这里有个cElementTree网站做的[对比](https://stackoverflow.com/a/19302655)：

```
library                         time    space
xml.dom.minidom (Python 2.1)    6.3 s   80000K
gnosis.objectify                2.0 s   22000k
xml.dom.minidom (Python 2.4)    1.4 s   53000k
ElementTree 1.2                 1.6 s   14500k  
ElementTree 1.2.4/1.3           1.1 s   14500k  
cDomlette (C extension)         0.540 s 20500k
PyRXPU (C extension)            0.175 s 10850k
libxml2 (C extension)           0.098 s 16000k
readlines (read as utf-8)       0.093 s 8850k
cElementTree (C extension)  --> 0.047 s 4900K <--
readlines (read as ascii)       0.032 s 5050k   
```

可以见到为了追求性能的话，基本上会选择C扩展的库；而如果优先考虑接口简单的话，还可以看看lxml、xlmtodict等库。



### 一、HTMLParser方式

HTMLParser的方式对函数式可能没那么友好，因为它必须要继承一个HTMLParser，然后通过钩子函数来调用parsing的回调。

当然你也可以写一个函数来封装这个行为，但这样的设计会导致几个handle方法之间不能共享数据状态。在starttag、endtag和data这几个事件之间，往往是识别一个节点及其数据的顺序流程，因此通过class来写的话就可以用对象属性来做共享状态。

```python
# 引用自官方文档的例子：
from html.parser import HTMLParser

class MyHTMLParser(HTMLParser):
    def handle_starttag(self, tag, attrs):
        print("Encountered a start tag:", tag)

    def handle_endtag(self, tag):
        print("Encountered an end tag :", tag)

    def handle_data(self, data):
        print("Encountered some data  :", data)

parser = MyHTMLParser()
parser.feed('<html><head><title>Test</title></head>'
            '<body><h1>Parse me!</h1></body></html>')

# 可以封装成方法，但几个handle方法之间不方便共享状态
def createHtmlParser(handle_starttag, handle_endtag, handle_data):
    class MyHTMLParser(HTMLParser):
    	def handle_starttag(self, tag, attrs):
        	handle_starttag(tag, attrs)

    	def handle_endtag(self, tag):
        	handle_endtag(tag)

    	def handle_data(self, data):
            handle_data(data)
            
    return MyHTMLParser()
```



### ElementTree方式

ElementTree是Python封装的一个比较常用的API方式，它的目标是尽可能提供接近层级结构的树形API，包括ElementTree和Element两个对象。对于与整个文档（读写）交互的方法，封装在ElementTree里；而对于与节点交互的方法，则写在Element对象里。

默认情况下，ET期望的是一次性读完整个文件，从而构造出一个文档树的结构，再通过获取root节点从而操作节点内容。而对于某些情况下希望以增量的方式（比如流式）解析的场景，ET也提供了一个XMLPullParser，以feed()和read_events()的方式

```python
import xml.etree.ElementTree as ET
# 从文件读取数据
tree = ET.parse('country_data.xml')
root = tree.getroot()
# 从字符串里面读取数据
root = ET.fromstring(country_data_as_string)

# 流式读取数据
parser = ET.XMLPullParser(['start', 'end'])
parser.feed('<mytag>sometext') # 读取部分内容
list(parser.read_events()) # 获取到部分事件 => [('start', <Element 'mytag' at 0x7fa66db2be58>)]
parser.feed(' more text</mytag>') # 继续读取部分内容
for event, elem in parser.read_events(): # 继续获取新的内容
	print(event)
	print(elem.tag, 'text=', elem.text)
    
```

ET的节点操作主要包括tag、attributes和child。也可以使用遍历（iter）、查找（findall）等方式访问到节点下面的子树（包括子级的子级）。

```python
# 使用iter()方法进行深度优先遍历
for neighbor in root.iter('neighbor'):
	print(neighbor.attrib)

# 使用findall方法进行查找
for country in root.findall('country'): # findall：找到所有吻合的标签
    rank = country.find('rank').text # find：找到第一个吻合的标签
    name = country.get('name') # 获取元素的属性
    print(name, rank)
    
```

与上面的HTMLParser不同，ET可以构建一个XML文档并且写入到文件。

```python
for rank in root.iter('rank'):
    new_rank = int(rank.text) + 1
    rank.text = str(new_rank) # 通过.text来改变节点内容
    rank.set('updated', 'yes') # 通过.set()方法设置属性值

tree.write('output.xml')  # 写入到文件

# 直接创建Element对象
a = ET.Element('a')
b = ET.SubElmeent(a, 'b')
ET.dump(a) # 用dump方法直接把xml文档转换成字符串
root.append(a) # 通过append()添加子节点
a.remove(b) # 通过remove()删除子节点

```

关于XML还有其他一些主题要了解的，这里不详说：

* [使用Namespace解析XML](https://docs.python.org/zh-cn/3/library/xml.etree.elementtree.html#parsing-xml-with-namespaces)。如果XML文档本身有使用namespace（一条uri字符串 ）的话，那么标签前面加了namespace相应的name，在find/findall的时候也要加上namespace信息，才能准确找到相应的节点。查询方法有两种：一种是直接把namespace的URI写在标签前面；另一种是传一个namespace的对象给查找方法，确定没



### DOM方式

(to be filled)

### SAX方式

(to be filled)

### XML Schema校验



### XML解析的安全问题

官方文档[指出](https://docs.python.org/3.8/library/xml.html#xml-vulnerabilities)，XML的处理过程对于一些有针对性构造的恶意数据，可能会引起一些安全问题，如：

* denial-of-service(DoS)，拒绝服务
* 访问本地文件
* 产生对其他机器的网络请求
* 越过防火墙

| kind                                                         | sax            | etree          | minidom        | pulldom        | xmlrpc         |
| :----------------------------------------------------------- | :------------- | :------------- | :------------- | :------------- | :------------- |
| billion laughs                                               | **Vulnerable** | **Vulnerable** | **Vulnerable** | **Vulnerable** | **Vulnerable** |
| quadratic blowup                                             | **Vulnerable** | **Vulnerable** | **Vulnerable** | **Vulnerable** | **Vulnerable** |
| external entity expansion                                    | Safe           | Safe           | Safe           | Safe           | Safe           |
| [DTD](https://en.wikipedia.org/wiki/Document_type_definition) retrieval | Safe           | Safe           | Safe           | Safe           | Safe           |
| decompression bomb                                           | Safe           | Safe           | Safe           | Safe           | **Vulnerable** |

上述攻击方法的一些介绍：

* billion laughs / exponential entity expansion （狂笑/递归实体扩展）。一种DoS攻击（[wiki链接](https://en.wikipedia.org/wiki/Billion_laughs_attack)），也称为“指数实体扩展攻击”，通过多层嵌套引用另一个实体，导致内存消耗呈指数扩展，耗尽服务器可用内存。
* quadratic blowup entity expansion（二次爆炸实体扩展）。滥用实体扩展，类似“狂笑”，但绕过了一些解析器专门设计的深度嵌套检测的对策。
* external entity expansion，实体声明里包含一些外部资源或本地文件，从而让XML解释器访问资源并将内容嵌入到XML文档中
* DTD retrieval，让XML解释器从远程或本地位置检索文档类型定义。
* decompression bomb，对于可以解压缩XML流的库来说，通过这种方式让库解压出三个或以上数量级的数据从而影响库的性能。

