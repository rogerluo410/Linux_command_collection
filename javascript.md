**JS中获取HTML标签对象**  
* 在JS中使用 $('#images-mask')， 取得标签id    = images-mask 的对象  
* 在JS中使用 $('.images-mask')， 取得标签class = images-mask 的对象  

**在JS中动态添加标签**  
```
obj = '<div>...</div>'
$(obj) 表示使用这个标签对象  
var sData =  JSON.stringify(data);
            var jData =  JSON.parse(sData);
            //alert(jData["photos"])
            var images = ""
            for (var i in jData["photos"]) {
                //alert (i)
                 images += '<a href="#" class="preview"><img class="img" src="'+ jData["photos"][i]["photo_addr"] +'" alt="" /></a>';

            }
            $('#images-mask').html($(images));
```


http://jsfiddle.net/  -- js test

http://www.js-css.cn/a/jscode/album/    --JQuery特效

http://www.sencha.com/products/extjs/up-and-running  --Ext.js instruction  

http://blog.csdn.net/qq838419230/article/details/8026390  --Javascript learning  

http://www.ituring.com.cn/article/8108               --JavaScript宝座：七大框架论剑  

http://www.ituring.com.cn/article/38394              --JavaScript MVC框架PK：Angular、Backbone、CanJS与Ember  

http://www.cnblogs.com/jinguangguo/p/3534422.html    --侃侃前端MVC设计模式

对于比较流行的 Javascript MVC 框架应该如何选择？
> http://www.zhihu.com/question/20381805

"我觉得这个讨论还需要设定一个前提——项目类型是什么，是互联网应用还是企业（Web）应用？互联网应用也要分电子商务、社交网络、门户网站，
不同项目应该有不同的最优选择（如果存在最优选择的话）。"


###1.Asynchronous/Synchronous Javascript
a.Unless, and this is the answer to your second question, you specify that the Ajax call should be synchronous, which is an option. Doing so will force the user to wait until the call completes before they can do anything, so that's usually not the best choice. Using a callback is usually the best approach.

b.Additionally, if you want foo() to remain asynchronous but execute foobar() when it is complete, you could use foobar() as a callback. That way you can continue down your JS logic, but you can still make certain functions wait if they need to.
  	 	
c.Gotcha, thanks! kingjiv said the exact phrase I was looking for - foobar will only be called once all of the javascript in foo is complete. I was thinking about this whole thing way too generally, and needed to think very strictly and literally. :)

> http://stackoverflow.com/questions/6748287/asynchronous-synchronous-javascript


###2.Javascript by reference vs. by value
My understanding is that this is actually very simple:

- **.**Javascript is always pass by value, but when a variable refers to an object (including arrays), the "value" is a reference to the object.
- **.**Changing the value of a variable never changes the underlying primitive or object, it just points the variable to a new primitive or object.
- **.**However, changing a property of an object referenced by a variable does change the underlying object.
So, to work through some of your examples:
```
function f(a,b,c) {
    // Argument a is re-assigned to a new value.
    // The object or primitive referenced by the original a is unchanged.
    a = 3;
    // Calling b.push changes its properties - it adds
    // a new property b[b.length] with the value "foo".
    // So the object referenced by b has been changed.
    b.push("foo");
    // The "first" property of argument c has been changed.
    // So the object referenced by c has been changed (unless c is a primitive)
    c.first = false;
}

var x = 4;
var y = ["eeny", "miny", "mo"];
var z = {first: true};
f(x,y,z);
console.log(x, y, z.first); // 4, ["eeny", "miny", "mo", "foo"], false
```
Example 2:

```
var a = ["1", "2", {foo:"bar"}];
var b = a[1]; // b is now "2";
var c = a[2]; // c now references {foo:"bar"}
a[1] = "4";   // a is now ["1", "4", {foo:"bar"}]; b still has the value
              // it had at the time of assignment
a[2] = "5";   // a is now ["1", "4", "5"]; c still has the value
              // it had at the time of assignment, i.e. a reference to
              // the object {foo:"bar"}
console.log(b, c.foo); // "2" "bar"
```
> http://stackoverflow.com/questions/6605640/javascript-by-reference-vs-by-value


###Javascript
* JavaScript中有两种主要对象：  
 a.Native:  
     JavaScript中内置的标准对象(Date, Array)；   
 b.Host:  
     JavaScript宿主环境对象(浏览器环境--window)。  
     
       
* JavaScript中有5中基本类型：number，string，boolean，null，undefined；   
number，string，boolean可以非常容易的由程序猿或者解释器转换成JavaScript对象；  
函数(Function)也是对象，也能有属性和方法。 


* 文档对象模型DOM里document的常用的查找访问节点的方法:    
Document.getElementById    --根据元素id查找元素   
Document.getElementByName  --根据元素name查找元素   
Document.getElementTagName --根据指定的元素名查找元素  


* 浏览器对象模型DOM里常用的至少4个对象，并列举window对象的常用方法:    
对象：Window  document  location  screen  history  navigator     
方法：Alert()  confirm()  prompt()  open()  close()  


* AJAX技术体系的组成部分有哪些？  
HTML，css，dom，xml，xmlHttpRequest，javascript    
通过HTTP Request， 一个web页面可以发送一个请求到web服务器并
且接受web服务器返回的信息(不用重新加载页面)，展示给用户的还是通一个页面，用户感觉页面刷新，也看不到到Javascript后台进行的发送请求和接受响应。   

###Javascript语法   

> http://www.runoob.com/js/js-tutorial.html    --js教程  

- Array对象    
```
var cars = ["Saab", "Volvo", "BMW"];  
```  

- String 对象  
```
var txt = new String("string");
或者更简单方式：
var txt = "string";
```


