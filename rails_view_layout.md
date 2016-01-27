##一、如何渲染 
1、如有以下控制器 
```
BooksController  
    def show  
        @book = Book.find(params[:id])  
    end  
end
```  

Rails将自动渲染 app/views/books/show.html.erb 

2、事实上，如果你设置了捕获所有路由 `map.connect':controller/:action/:id'`， 
Rails将自动渲染views，即使在controller里面你没有写任何代码。 

3、真正渲染页面的类是：`ActionView::TemplateHandlers`   
 
4、反馈一个空的结果给浏览器   
`render :nothing => true`   

5、`render_to_string` 渲染字符串（最直接的方式）    

6、使用相同controller下的别的action的模板来渲染 
以下渲染edit.html.erb模板的方式，不会执行edit#action里的代码，因此模板里调用的实例变量，都必须在渲染前赋值好 
```
def update  
    @book = Book.find(params[:id])  
    if @book.update_attributes(params[:book])  
        redirect_to(@book)  
    else  
        render "edit"   
        #render :edit  
        #render :action => "edit" #旧的方式  
    end  
end  
```

7、使用不同controller下的某个action的模板来渲染     
`render 'products/show'`    
`render :template => 'products/show'` #旧的方式     

8、渲染任意的文件 
默认情况下，渲染任意文件不会使用当前layout，   
如果想使用当前layout，加上:layout => true   
`render "/u/apps/warehouse_app/current/app/views/products/show"`   
`render :file => "/u/apps/warehouse_app/current/app/views/products/show"`   #旧的方式 

9、在controller内inline渲染（字符串模板）    
`render :inline => "<% products.each do |p| %><p><%= p.name %></p><% end %>"`    
默认情况下，inline渲染使用ERB，但你可强制使用Builder    
`render :inline => "xml.p {'Horrid coding practice!'}", :type => :builder`    

10、渲染文本   
默认情况下，渲染文本不会使用当前layout，如有需要，加上 :layout => true。   
`render :text => "OK" `

11、渲染JSON    
不需要@product.to_json，render会自动调用该方法 
`render :json => @product` 

12、渲染XML   
`render :xml => @product` 

13、渲染选项 Options 

:content_type   
`render :file => filename, :content_type => 'application/rss'`   

:layout    
`render :layout => 'special_layout' `      
`render :layout => false`    

:status    
`render :status => 500`       
`render :status => :forbidden #被禁止的`    

可以在actionpack/lib/action_controller/status_codes.rb文件里找到symbol和status的对映关系   

:location    
`render :xml => photo, :location => photo_url(photo) `  

14、寻找layout 
Rails首先会在app/views/layouts目录下查找与controller同名的layout文件， 
如果没有找到，则会使用app/views/layouts/application.html.erb或app/views/layouts/application.builder。   
除以上文件都外，Rails还提供多种方式来选择layout。 

**为controller指定layout，替换默认的layout**   
```
Class ProductsController < ApplicationController 
layout "inventory" 
   #... 
end 
```

**指定一个全局的layout**    
```
class ApplicationController < ActionController::Base 
layout "main" 
  #... 
end
``` 

**在运行时中指定layout(动态的layout)** 
```   
class ProductsController < ApplicationController   
layout :products_layout   

def show 
 @product = Product.find(params[:id]) 
end 

private 
 def products_layout 
  @current_user.special? ? "special" : "products"    
 end   
end  
```
 
```
class ProductsController < ApplicationController 
layout proc { |controller| controller.request.xhr? ? 'popup' : 'application' } 
  # ... 
end 
```

**带条件的layout设置**     
除index和rss这两个action之外，其余action都使用名为product的layout，rss这个layout只有rss这个action使用 
```
class ProductsController < ApplicationController 
  layout "product", :except => [:index, :rss] 
  layout "rss",only => :rss 
  #... 
end 
```

**layout继承**    
ApplicationController的layout设置 <-- Controller的layout设置 <-- render方法的layout选项 
本地的设置会覆盖父级的设置，如果本级无设置，则继承父级的设置 

15、避免重复渲染     
def show    
  @book = Book.find(params[:id])    
  if @book.special?    
    render :action => "special_show" and return    
  end   
  render :action => "regular_show"    
end      


16、使用跳转redirect_to    
redirect_to给浏览器的响应是：告诉浏览器发起一个新的请求    

```
redirect_to photos_path 
redirect_to :back 
redirect_to photos_path, :status => 301 #301临时跳转 
redirect_to photos_path, :status => 302 #302永久跳转 
```

17、redirect_to和render的区别    
render渲染用户指定的模板作为响应    
redirect_to会结束当前响应，并告诉浏览器请求一个新的url    

有些经验不足的开发者会认为 redirect_to 方法是一种 goto 命令，把代码从一处转到别处。这么理解是不对的。执行到 redirect_to 方法时，代码会停止运行，等待浏览器发起新请求。你需要告诉浏览器下一个请求是什么，并返回 302 状态码。 

```
def index
  @books = Book.all
end
 
def show
  @book = Book.find_by(id: params[:id])
  if @book.nil?
    render action: "index"
  end
end
```
在这段代码中，如果 @book 变量的值为 nil 很可能会出问题。记住，render :action 不会执行目标动作中的任何代码(仅仅会渲染目标动作中对应的模板)，因此不会创建 index 视图所需的 @books 变量。修正方法之一是不渲染，使用重定向：

```
def index
  @books = Book.all
end
 
def show
  @book = Book.find_by(id: params[:id])
  if @book.nil?
    redirect_to action: :index
  end
end
```


18、响应时只返回HTTP header   
`head :bad_request `       
`head :created, :location => photo_path(@photo)`       


##二、结构化布局 

1、资源标记Asset Tags 
* auto_discovery_link_tag 
* javascript_include_tag 
* stylesheet_link_tag 
* image_tag 

```
<%= auto_discovery_link_tag(:rss, {:action => “feed”}, {:title => “RSS Feed”} %> 
<%= javascript_include_tag "main", "/photos/columns" %> 
```

缓存脚本     
`<%= javascript_include_tag "main", "columns", :cache => true %> `

缓存css     
`<%= stylesheet_link_tag "main", "columns", :cache => true %>` 

Img标记    
`<%= image_tag "icons/delete.gif", :height => 45 %>` 

2、理解yield和content_for  
```
<html>  
<head>  
<%= yield :head %>  
</head>  
<body>  
<%= yield %>  
</body> 
</html> 
```
```
<% content_for :head do %> 
<title>A simple page</title> 
<% end %> 
<p>Hello, Rails!</p> 
```

3、使用partials 
渲染模板同级目录下的_menu.html.erb   
`<%= render :partial => "menu" %> `

渲染app/views/shared/_menu.html.erb   
`<%= render :partial => "shared/menu" %>`   

4、为partial指定layout    
`<%= render :partial => "link_area", :layout => "graybar" %> `   

5、渲染partial时传递局部变量 
**view模板文件**    
`<%= render :partial => "form", :locals => { :button_label => "Create zone", :zone => @zone } %>`   

**partial模板文件form**  
``` 
<% form_for(zone) do |f| %>  
<p>  
<b>Zone name</b><br />  
<%= f.text_field :name %>  
</p>  
<p>  
<%= f.submit button_label %>  
</p> 
<% end %> 
```

6、每一个partial拥有一个和文件名相同的默认局部变量(不包括_) 
如_customer.html.erb拥有`customerp`这个默认局部变量 

`<%= render :partial => "customer", :object => @new_customer %>`   

使用:object选项传递变量时，变量将会传递给partial的默认变量`customerp`    

7、渲染集合 
index.html.erb :   
```  
<h1>Products</h1> 
<%= render :partial => "product", :collection => @products %> 
```

_product.html.erb :   
```
<p>Product Name: <%= product.name %></p> 
```

@products的每一个product都会渲染一次_product.html.erb， 
如果:collection选项指定的变量为partial中引用变量的复数形式，那么渲染时自动传递集合变量的成员给partail，如果不符合这条惯例，则需要加:as选项指定   
`<%= render :partial => "product", :collection => @products, :as => :item %> `

8、集合计数器 
rails在渲染partial传递集合时，会传递一个集合计数器给partial 
如传递@products，那么也将传递给product_counter给partial, 
告诉你多少个partail已经被渲染了 

9、渲染集合时使用间隔模板 
以下代码会使用_product模板渲染每一个product后，渲染_product_ruler模板   
`<%= render :partial => "product", :collection => @products, :spacer_template => "product_ruler" %>`    


10、嵌套布局 
Using Nested Layouts 

You may find that your application requires a layout that differs slightly from your regular application layout to support one particular controller. Rather than repeating the main layout and editing it, you can accomplish this by using nested layouts (sometimes called sub-templates). Here’s an example: 

Suppose you have the follow ApplicationController layout: 

app/views/layouts/application.html.erb :

```
<html> 
 <head> 
  <title>
   <%= @page_title or 'Page Title' %>
  </title> 
  <%= stylesheet_link_tag 'layout' %> 
  <style type="text/css">
   <%= yield :stylesheets %>
  </style> 
 </head> 
 <body> 
 <div id="top_menu">Top menu items here</div> 
 <div id="menu">Menu items here</div> 
 <div id="content"><%= yield(:content) or yield %></div> 
 </body> 
</html> 
```

On pages generated by NewsController, you want to hide the top menu and add a right menu: 

app/views/layouts/news.html.erb :   

```
<% content_for :stylesheets do %> 
 #top_menu {display: none} 
 #right_menu {float: right; background-color: yellow; color: black} 
<% end -%> 
<% content_for :content do %> 
 <div id="right_menu">Right menu items here</div> 
 <%= yield(:news_content) or yield %> 
<% end -%> 
<% render :file => 'layouts/application' %> 
```

That’s it. The News views will use the new layout, hiding the top menu and adding a new right menu inside the “content” div.   

There are several ways of getting similar results with different sub-templating schemes using this technique. Note that there is no limit in nesting levels. One can use the ActionView::render method via render :file => 'layouts/news' to base a new layout on the News layout. If one is sure she will not subtemplate the News layout, she can ommit the yield(:news_content) or part.   
