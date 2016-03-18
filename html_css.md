#经典文章

- 大公司里怎样开发和部署前端代码？  
> http://www.runoob.com/w3cnote/how-to-develop-and-deploy-front-end-code.html


**1.Draw a line on panel :**

  > Write something like this : 
  
  ```
   border-left: 1px solid black;
  ```
  
**2.padding:5px 15px 5px 15px; How to recognize it?**
  ```
  border 视为盒子的外壳，padding则视为盒子中的缓冲填充物，比如泡沫，那么剩下的就是盒子真正可以放东西的空间，比如里面的鞋子.
  margin 你可以理解为这个盒子和其他盒子之间的间隔，距离  
  
  padding:5px 15px 5px 15px; --->  上 右 下 左  (顺时针方向)
  ```
  
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
  
  




