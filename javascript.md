**JS中获取HTML标签对象**  
$("#id")是jquery写法，和GetElementById一样   
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

- JavaScript对象  
```
var obj = {firstName:"John", lastName:"Doe", age:50, eyeColor:"blue"}  
属性：  
car.name = Fiat
car.model = 500
car.weight = 850kg
car.color = white	

方法 
car.start()
car.drive()
car.brake() 
car.stop()

你可以使用以下语法创建对象方法：
methodName : function() { code lines }  --值为一个匿名函数  
var obj = {firstName:"John", methodName : function() { code lines } }

你可以使用以下语法访问对象方法：
objectName.methodName()
```  

- 函数（Function） 
```javascript
function MyFunc(a, b) { return a * b }

函数回调： 

function myFunction(a,b)
{
  return a*b;
}
	
function new_one(c, d )
{
  return c(1,2) + d
}

document.getElementById("demo").innerHTML=new_one(myFunction,3);  

 if (typeof callback === "function") {
    // Call it, since we have confirmed it is callable
        callback(options);
    } 


JavaScript 闭包  

var add = (function () {
    var counter = 0;
    return function () {return counter += 1;}
})();

add();
add();
add();

// 计数器为 3

add变量可以作为一个函数使用。非常棒的部分是它可以访问函数上一层作用域的计数器。
这个叫作 JavaScript 闭包。它使得函数拥有私有变量变成可能。
计数器受匿名函数的作用域保护，只能通过 add 方法修改。
```

-  HTML DOM EventListener  
```javascript
document.getElementById("myBtn").addEventListener("click", displayDate);  

element.addEventListener(event, function, useCapture);
第一个参数是事件的类型 (如 "click" 或 "mousedown").
第二个参数是事件触发后调用的函数。
第三个参数是个布尔值用于描述事件是冒泡还是捕获。该参数是可选的。

向原元素添加事件句柄： 
element.addEventListener("click", function(){ alert("Hello World!"); });  

向 Window 对象添加事件句柄： 
window.addEventListener("resize", function(){
    document.getElementById("demo").innerHTML = sometext;
});
----------------------------------------------
var p1 = 5; //p1,p2 为两个全局作用域的变量. 
var p2 = 7;

document.getElementById("myBtn").addEventListener("click", function() {
    myFunction(p1, p2); //此处可以使用p1,p2
});

function myFunction(a, b) {
    var result = a * b;
    document.getElementById("demo").innerHTML = result;
}
-------------------------------------------
匿名函数 和 函数 可以这么理解： 
function func1(a,b) { return a*b; }

to equal  :

var func1 = function(a,b){ return a*b; }

function(a,b){ return a*b; } 这个本身就是一匿名函数.  
```

- JavaScript 全局变量  
```
变量在函数外定义，即为全局变量。
全局变量有 全局作用域: 网页中所有脚本和函数均可使用。 

var carName = " Volvo";

// 此处可调用 carName 变量

function myFunction() {

    // 函数内可调用 carName 变量 

}


JavaScript变量生命周期:  

* JavaScript 变量生命周期在它声明时初始化。
* 局部变量在函数执行完毕后销毁。
* 全局变量在页面关闭后销毁。

HTML中的全局变量:  
在 HTML 中, 全局变量是 window 对象: 所有数据变量都属于 window 对象。  

//此处可使用 window.carName

function myFunction() {
    carName = "Volvo";
}

```



# Jquery  

> http://www.365mini.com/page/jquery-quickstart.htm  --Jquery 手册  

* 捕获浏览器前进后退按钮的事件：   
```
  window.addEventListener('popstate', function(event) {
    load_flag = 1;
  }, false);
```  

* 页面加载事件：  
$(window).load();  所有的资源(DOM，CSS，JS，Images)被加载后，会触发这个事件。  

$(document).ready();   在DOM被加载， 准备加载JS文件之前，会触发这个事件。

$(window).unload();  This event will be fired when you are navigating off the page. That could be Refresh/F5, pressing the previous page button, navigating to another website or closing the entire tab/window.  

To sum up, ready() will be fired before load(), and unload() will be the last to be fired.  


* 函数中获得 selector ：
```
selector = '.ui .selector'
function search_input(selector){
 var term =  $(selector).val();
 if(term){
   search(term);
 }
}
```

* 通过浏览器对象window (BOM)对象重定向url：  
window.location.href = '/search?q=' + term;  
window.history.back()  url后退
window.history.forward() url前进

```
window.addEventListener("resize", function(){
    document.getElementById("demo").innerHTML = sometext;
});  //向浏览器对象window添加事件
```

* 事件(点击事件等)被触发时， 在事件处理函数中， 可以使用一个event对象， 包含以下信息：  

```
  $(".search_key").click(function(event){
    event.preventDefault(); 阻止这个事件原本的动作。
    event.currentTarget  触发该事件的dom元素 
    event.type  事件类型 click 等
    event.timeStamp 事件触发时间戳
    event.stopPropagation();  用于阻止当前事件在DOM树上冒泡
根据DOM事件流机制，在元素上触发的大多数事件都会冒泡传递到该元素的所有祖辈元素上，如果这些祖辈元素上也绑定了相应的事件处理函数，就会触发执行这些函数。

使用stopPropagation()函数可以阻止当前事件向祖辈元素的冒泡传递，也就是说该事件不会触发执行当前元素的任何祖辈元素的任何事件处理函数。

该函数只阻止事件向祖辈元素的传播，不会阻止该元素自身绑定的其他事件处理函数的函数。event.stopImmediatePropagation()不仅会阻止事件向祖辈元素的传播，还会阻止该元素绑定的其他(尚未执行的)事件处理函数的执行。

此外，由于live()函数并不是将事件处理函数直接绑定到自己身上，而是"委托"绑定到祖辈元素上，由祖辈元素来触发执行。live()函数会先一次性冒泡到文档的顶部，然后为符合条件的元素触发事件。因此，stopPropagation()函数无法阻止live事件的冒泡。

同样地，delegate()函数也是"委托事件函数"，只有事件冒泡传递到"受委托"的祖辈元素才会被触发执行。因此，stopPropagation()函数无法阻止该元素到"受委托"的祖辈元素之间的事件冒泡。

该函数属于jQuery的Event对象。
  }
  
  $( document ).on( "mousemove", function( event ) {
    $( "#log" ).text( "pageX: " + event.pageX + ", pageY: " + event.pageY );
  });
```

* 事件冒泡或事件捕获？
事件传递有两种方式：冒泡与捕获。  
事件传递定义了元素事件触发的顺序。 如果你将 `<p>` 元素插入到 `<div>` 元素中，用户点击 `<p>` 元素, 哪个元素的 "click"   事件先被触发呢？     
在 `冒泡` 中，内部元素的事件会先被触发，然后再触发外部元素，即： `<p>` 元素的点击事件先触发，然后会触发 `<div>` 元素的点击事件  
在 `捕获` 中，外部元素的事件会先被触发，然后才会触发内部元素的事件，即： `<div>` 元素的点击事件先触发 ，然后再触发 `<p>`    元素的点击事件。    
addEventListener() 方法可以指定 "useCapture" 参数来设置传递类型：   
addEventListener(event, function, useCapture);   
默认值为 false, 即冒泡传递，当值为 true 时, 事件使用捕获传递。    
实例:   
```javascript   
document.getElementById("myDiv").addEventListener("click", myFunction, true);
```
