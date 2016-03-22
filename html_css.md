#经典文章

- 大公司里怎样开发和部署前端代码？  
> http://www.runoob.com/w3cnote/how-to-develop-and-deploy-front-end-code.html

  
#CSS
```
1.id selector 
#para1 
{
  text-align:center;
  color:red;
}
example : <p id='para1'>...</p>

2.class selector
.center
{
  text-align:center;
}
example : <p class='center'>...</p>

3.specified class selector
p.center 
{
  text-align: center;
}

```

> Instruction :  http://www.w3schools.com/css/default.asp   

###CSS 预处理器技术   
CSS 预处理器是一种语言用来为 CSS 增加一些编程的的特性，无需考虑浏览器的兼容性问题，例如你可以在 CSS 中使用变量、简单的程序逻辑、函数等等在编程语言中的一些基本技巧，可以让你的 CSS 更见简洁，适应性更强，代码更直观等诸多好处。    
> http://www.oschina.net/question/12_44255


###Knowledge  
**1.Draw a line on panel :**

  Write something like this : 
  
  ```
   border-left: 1px solid black;
  ```
  
**2.padding:5px 15px 5px 15px; How to recognize it?**
  ```
  border 视为盒子的外壳，padding则视为盒子中的缓冲填充物，比如泡沫，那么剩下的就是盒子真正可以放东西的空间，比如里面的鞋子.
  margin 你可以理解为这个盒子和其他盒子之间的间隔，距离  
  
  padding:5px 15px 5px 15px; --->  上 右 下 左  (顺时针方向)
  ```

#HTML  
###布局 
  CSS中存在三种定位机制： 1.标准文档流(Normal flow)  2.浮动(Floats)  3.绝对定位(Absolute positioning)   
  
* 自动居中一列布局 (标准文档流，从上至下，从左至右)    
  块级元素(独占一行):div, ul,li, dl, dt,p ， 行级元素: span, strong, img, input。  
  样式表分为： 行级 > 内部 > 外部样式表    
  
  盒子模型:  
```
padding
margin
border

with: 
top, right, bottom, left   

including:  
width, height  

盒子level:  
1.border  
2.content + padding  
3.background image
4.background color  
5.margin  
```  
div 的样式为 `#div1{ width:770px; margin: 0 auto;}` 上下为0，左右为auto的外边距可以让这个div居中,并且不要设置浮动和绝对定位。  
  
* 横向两列布局（浮动） 
块级元素横向排版  

利用块级元素的float属性实现  
```
float: left; right; none--不浮动 ， 左移或右移直到触碰到容器边缘。   

设置浮动后，紧邻之后的元素会受到影响，需要在该元素中清除浮动。   
clear: both; left; right;  
```

* 绝对布局， 是用position属性定位  
```
 position: static; 静态定位
 
          relative; 相对定位（相对自身初始位置的偏移），会产生偏移属性和z-index z轴 
  #div{position: relative; top:50px; left:30px;} #相对定位，并设置从初始位置开始偏移。          
          
          absolute; 绝对定位(相对父节点的偏移并且父节点也需要定位，如果没有父节点定位，则以<html>作为父节点) ，完全脱离标准文档流，会产生偏移属性和z-index z轴 。
                    当一个元素设置绝对定位后，没有设置宽度，元素的宽度根据内容进行调节，例如设置width: 500px;。  
          
          fixed;    绝对定位 固定定位   
```
  
###HTML DOM对象  
1. 在 HTML DOM (Document Object Model) 中, 每一个元素都是节点:  
 - 所有的HTML元素都是元素节点。  
 - 所有 HTML 属性都是属性节点。  

2. Document对象  
 - 当浏览器载入 HTML 文档, 它就会成为 document 对象。
 - document 对象是HTML文档的根节点与所有其他节点（元素节点，文本节点，属性节点, 注释节点）。
 - Document 对象使我们可以从`脚本(Javascript)`中对 HTML 页面中的所有元素进行访问。
 > 提示：Document 对象是 Window 对象的一部分，可通过 window.document 属性对其进行访问。  

3. Document对象属性和方法   
 - document.addEventListener()	向文档添加句柄  
 - document.body	返回文档的body元素  
 - document.cookie	设置或返回与当前文档有关的所有 cookie。  
 - document.createElement()	创建元素节点。  
 - document.createTextNode()	创建文本节点。  
 - document.createAttribute()	创建一个属性节点  
 - document.documentElement	返回文档的根节点   
 - document.getElementById()	返回对拥有指定 id 的第一个对象的引用。  
 - document.getElementsByName()	返回带有指定名称的对象集合。  
 - document.getElementsByTagName()	返回带有指定标签名的对象集合。  
 - document.removeEventListener()	移除文档中的事件句柄(由 addEventListener() 方法添加)  

4. HTML DOM 元素对象  
  在 HTML DOM 中, 元素对象代表着一个 HTML 元素。  
  元素对象的子节点可以是, 可以是元素节点，文本节点，注释节点。  

  元素对象的属性和方法:  
   - element.accessKey	设置或返回accesskey一个元素   
   - element.addEventListener()	向指定元素添加事件句柄  
   - element.appendChild()	为元素添加一个新的子元素  
   - element.attributes	返回一个元素的属性数组  
   - element.childNodes	返回元素的一个子节点的数组  
   - element.getAttribute()	返回指定元素的属性值  
   - element.id	设置或者返回元素的 id。  
   - element.innerHTML	设置或者返回元素的内容。  
   - element.removeAttribute()	从元素中删除指定的属性  
   - element.removeChild()	删除一个子元素  
   - element.style	设置或返回元素的样式属性  


5. Attr 对象  
  在 HTML DOM 中, Attr 对象 代表一个 HTML 属性。 HTML属性总是属于HTML元素。   

  - attr.isId	  Returns true if the attribute is of type Id, otherwise it returns false   
  - attr.name	  返回属性名称   
  - attr.value	设置或者返回属性值   

6. HTML DOM 事件   
  HTML DOM 事件允许Javascript在HTML文档元素中注册不同事件处理程序。  
  事件通常与函数结合使用，函数不会在事件发生前被执行！

  - 鼠标事件  
  (1) onclick	当用户点击某个对象时调用的事件句柄。  
  (2) ondblclick	当用户双击某个对象时调用的事件句柄。  
  (3) onmouseenter	当鼠标指针移动到元素上时触发。  
  (4) onmouseleave	当鼠标指针移出元素时触发。  
  (5) onmouseover	鼠标移到某元素之上。  
  (6) onmouseout	鼠标从某元素移开。  
  
  - 框架/对象（Frame/Object）事件  
  (1) onabort	图像的加载被中断。 (object)  
  (2) onload	一张页面或一幅图像完成加载。  
  (3) onscroll	当文档被滚动时发生的事件。  
  (4) onresize	窗口或框架被重新调整大小。  

  - 表单事件  
```
  (1) onblur	元素失去焦点时触发。  
  (2) onchange	该事件在表单元素的内容改变时触发( <input>, <keygen>, <select>, 和 <textarea>)。     
  (3) onfocus	元素获取焦点时触发。  
  (4) onselect	用户选取文本时触发 ( <input> 和 <textarea>)。  
```  
  
  更多事件:  
  > http://www.runoob.com/jsref/dom-obj-event.html   

###浏览器对象  
浏览器对象有5个:  

- Window 对象  
``` 
  Window 对象表示浏览器中打开的窗口。   
  如果文档包含框架（<frame> 或 <iframe> 标签), 浏览器会为HTML文档创建一个 window 对象, 并为每个框架创建一个额外的 window 对象。   
  其他4个对象,在window 对象中都有包含的子对象。     
   - Navigator(Navigator对象包含有关浏览器的信息),    
   
   - Screen对象(Screen 对象包含有关客户端显示屏幕的信息),  
   
   - History对象(History 对象包含用户（在浏览器窗口中）访问过的 URL. History 对象是 window 对象的一部分,可通过 window.history 属性对其进行访问),   
   
   - Location对象,(Location 对象包含有关当前 URL 的信息。Location 对象是 window 对象的一部分，可通过 window.Location 属性对其进行访问) 
```






