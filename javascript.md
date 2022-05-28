
http://www.js-css.cn/a/jscode/album/                      --JQuery特效

http://www.sencha.com/products/extjs/up-and-running       --Ext.js instruction  

http://blog.csdn.net/qq838419230/article/details/8026390  --Javascript learning  

http://www.ituring.com.cn/article/8108                    --JavaScript宝座：七大框架论剑  

http://www.ituring.com.cn/article/38394                   --JavaScript MVC框架PK：Angular、Backbone、CanJS与Ember  

http://www.cnblogs.com/jinguangguo/p/3534422.html         --侃侃前端MVC设计模式

对于比较流行的 Javascript MVC 框架应该如何选择？
> http://www.zhihu.com/question/20381805

"我觉得这个讨论还需要设定一个前提——项目类型是什么，是互联网应用还是企业（Web）应用？互联网应用也要分电子商务、社交网络、门户网站，
不同项目应该有不同的最优选择（如果存在最优选择的话）。"

# 函数防抖与节流  

  - 防抖, 单位时间内执行一次调用， 如 search, 值在变化    
  - 节流, 单位时间内执行一次调用， 如鼠标单击, 值不变化   

# Asynchronous/Synchronous Javascript   
a.Unless, and this is the answer to your second question, you specify that the Ajax call should be synchronous, which is an option. Doing so will force the user to wait until the call completes before they can do anything, so that's usually not the best choice. Using a callback is usually the best approach.

b.Additionally, if you want foo() to remain asynchronous but execute foobar() when it is complete, you could use foobar() as a callback. That way you can continue down your JS logic, but you can still make certain functions wait if they need to.
  	 	
c.Gotcha, thanks! kingjiv said the exact phrase I was looking for - foobar will only be called once all of the javascript in foo is complete. I was thinking about this whole thing way too generally, and needed to think very strictly and literally. :)

> http://stackoverflow.com/questions/6748287/asynchronous-synchronous-javascript


# Javascript by reference vs. by value   
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


# Javascript   
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

### Javascript语法   

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
window.history.back();  //url后退   
window.history.forward(); //url前进   

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

* dom / window 加载完回调  
```
  $( document ).ready(function() {
      console.log( "ready!" );
   });
   
   use the shorthand $() for $( document ).ready(): 
   
   // Shorthand for $( document ).ready()
   $(function() {
      console.log( "ready!" );
    });
```

`$(document).ready()` :     
The document ready event fired when the HTML document is loaded and the DOM is ready, even if all the graphics haven’t loaded yet. If you want to hook up your events for certain elements before the window loads, then $(document).ready is the right place.       

`$(window).load()`  :      
The window load event fired a bit later, when the complete page is fully loaded, including all frames, objects and images. Therefore functions which concern images or other page contents should be placed in the load event for the window or the content tag itself.   

* 自调函数(function(){})()  
a）$实参:$是jQuery的简写，很多方法和类库也使用$,这里$接受jQuery对象，也是为了避免$变量冲突，保证插件可以正常运行。   
   
   ```  
    (function (window, document, undefined) {
	  // 
    })(window, document);
   ```
   "它们是直接调用的函数表达式。

这意味着它们在运行时被立即调用，

我们也不能再调用它们了，它们只运行一"     

# react.js   

Install on Mac OS :  
1. `brew intall npm`   
2. `npm install bower -g`  --全局安装bower(bower可以对第三方模块进行统一的版本管理或者迭代)   
3. `bower install react` --全局安装react    
4. `bower install --save react`  --实现在当前目录下安装react  
5. `bower install babel`  --实现在当前目录下安装JSX解释器   

Install Redux (Redux is a predictable state container for JavaScript apps.):  


# Chrome extension  
> http://lifehacker.com/5857721/how-to-build-a-chrome-extension  

- examples:    
https://github.com/nihal111/IITB-login-extension-Chrome

- Firefox extension  VS  Chrome extension.     

 * For Firefox the language is mostly JavaScript and XUL (XML UI Language). Although it is possible to use Python and XUL, or even have compiled code bound trough XPCOM/XPconnect. But that's definitely not for beginners.

 * For Chrome the language is actually JavaScript, HTML and CSS. It's very similar to developing web application.

See tutorials:   

Firefox: https://developer.mozilla.org/en/building_an_extension   
Chrome: http://code.google.com/chrome/extensions/getstarted.html   

# AngularJS，Ember.js，Backbone这类新框架与jQuery的重要区别在哪里？  

```
AngularJS，Ember.js，Backbone这类新框架与jQuery的区别如下：
1、本质区别
    AngularJS，Ember.js，Backbone这三者是框架，而jQuery是一个库；使用库是指，使用者的代码决定什么时候从库中调用一个特定的方法；使用框架则是，使用者实现了一些回调方法，到了特定的时候框架会去调用这些方法
2、数据绑定的区别
    在jQuery中，常常按照以下方式响应事件并修改视图：
    $.ajax({
	  url: '/myEndpoint.json',
	  success: function ( data, status ) {
	    $('ul#log').append('<li>Data Received!</li>');
	  }
	});
	
     相对于这样一个视图
     <ul class="messages" id="log">
     </ul>
     
     必须人工手动去引用并更新这个DOM节点，但是在AngularJS中，可以这样做
     $http( '/myEndpoint.json' ).then( function ( response ) {
	    $scope.log.push( { msg: 'Data Received!' } );
	});
     视图应该像下面这样
     <ul class="messages">
       <li ng-repeat="entry in log">{{ entry.msg }}</li>
     </ul>
     
     不管是数据如何修改，视图层也会自动随之发生变化，非常简洁！
     
	3、区别model层
	   在jQuery中，DOM类似于一种model，但是在AngularJS等框架中，拥有不同于jQuery中的model层以便可以以任何想要的方式去管理它，它是完全独立于视图之外的。这种方式是有助于进行数据绑定并且可以保持对分离的关注，而且可以具备更好的可测试性。
	4、关注点分离
	   AngularJS，Ember.js，Backbone这三个框架都是MVC框架，都是基于模型-视图-控制器的；关注分离，视图层显示记录，model层代表数据，你服务层用来执行这些可复用的任务。使用directive来执行dom操作并扩展视图，并将它和controller连接起来，这也就是其他方面提到的有关于增强可测试性的原因
	    而jQuery却无法实现
	5、依赖注入
	   AngularJS，Ember.js，Backbone这三个框架分析代码，找到这些参数，然后将代码中所需要的服务推送给使用者。
	    jQuery无法实现。

	    jQuery主要是用来操作DOM的，如果单单说jQuery的话就是这样一个功能，它的插件也比较多，大家也都各自专注一个功能，可以说jQuery体系是跟着前端页面从静态到动态崛起的一个产物，他的作用就是消除各浏览器的差异，简化和丰富DOM的API，简单易用。
	    而AngularJS、Ember.js、Backbone则是比较新的产物，他们的产生不是为了再页面上实现各种特效，而是为了构建更重量级的webapp，这种app通常只有一个页面，通常拥有丰富的数据和交互，业务逻辑耦合深，跟传统的web页面还是有比较大的差异的。他们通常把数据和逻辑还有展现之类的东西做了分离，可以更方便做出复杂的单页面应用。
```


# Gulp 和 browserify / webpack  
Gulp应该和Grunt比较，他们的区别我就不说了，说说用处吧。Gulp / Grunt 是一种工具，能够优化前端工作流程。比如自动刷新页面、combo、压缩css、js、编译less等等。简单来说，就是使用Gulp/Grunt，然后配置你需要的插件，就可以把以前需要手工做的事情让它帮你做了。

说到 browserify / webpack ，那还要说到 seajs / requirejs 。这四个都是JS模块化的方案。其中seajs / require 是一种类型，browserify / webpack 是另一种类型。


seajs / require : 是一种在线"编译" 模块的方案，相当于在页面上加载一个 CMD/AMD 解释器。这样浏览器就认识了 define、exports、module 这些东西。也就实现了模块化。

browserify / webpack : 是一个预编译模块的方案，相比于上面 ，这个方案更加智能。没用过browserify，这里以webpack为例。首先，它是预编译的，不需要在浏览器中加载解释器。另外，你在本地直接写JS，不管是 AMD / CMD / ES6 风格的模块化，它都能认识，并且编译成浏览器认识的JS。这样就知道，Gulp是一个工具，而webpack等等是模块化方案。Gulp也可以配置seajs、requirejs甚至webpack的插件。


### Webpack 
http://webpackdoc.com/  

1. Installing

2. Loader 

3. webpack.config.js  

4. Plugins  

5. 开发环境  

6. 故障处理
