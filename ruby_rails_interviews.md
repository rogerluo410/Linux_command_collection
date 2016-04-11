- 如果我在路由文件config/routes.rb 里追加下面一段路由设置,会生成几个路由呢?
resources :posts do
  member do
    get 'comments'
  end
  collection do
    post 'bulk_upload'
  end
end

- 说说 ruby 里的 hash 和 ActiveSupport 里的 HashWithIndifferentAccess 的区别.  

- 说说下面的这段写在控制器里的代码有什么问题,如果把它上线之后会有什么后果, 如何修复呢?   
```
class MyController < ApplicationController
  def options
    options = {}
    available_option_keys = [:first_option, :second_option, :third_option]
    all_keys = params.keys.map(&:to_sym)
    set_option_keys = all_keys & available_option_keys
    set_option_keys.each do |key|
      options[key] = params[key]
    end
    options
  end
end 
```

- CSRF 是什么, Rails 里针对它做了些什么?  

- 怎么创建一个Person 对象,可以让他成为其他Person 对象的父类, 可以参考下面Rails Console 里的演示. 还有如果你要给这个对象定义对应数据库表, 你需要在迁移的时候定义什么字段呢?
irb(main):001:0> john = Person.create(name: "John")
irb(main):002:0> jim = Person.create(name: "Jim", parent: john)
irb(main):003:0> bob = Person.create(name: "Bob", parent: john)
irb(main):004:0> john.children.map(&:name)
=> ["Jim", "Bob"]
挑战: 如果我们想得到该Person的第三级子类,如下面代码中示例,改做这么修改这个对象,对于数据库表定义,需要修改什么吗?
irb(main):001:0> sally = Person.create(name: "Sally")
irb(main):002:0> sue = Person.create(name: "Sue", parent: sally)
irb(main):003:0> kate = Person.create(name: "Kate", parent: sally)
irb(main):004:0> lisa = Person.create(name: "Lisa", parent: sue)
irb(main):005:0> robin = Person.create(name: "Robin", parent: kate)
irb(main):006:0> donna = Person.create(name: "Donna", parent: kate)
irb(main):007:0> sally.grandchildren.map(&:name)
=> ["Lisa", "Robin", "Donna"]

- 创建一个路由,能够显示不同啤酒的信息,路由 URL 看上去应该是这样子的: /beer/<beer type>, 而且用同一个控制器和动作来处理,还需要限定啤酒的类型,可用的类型是下面提到的:
IPA
brown_ale
pilsner
lager
lambic
hefeweizen
不属于这个系列的,返回404信息.

- 仔细看看下面的代码, 看看他们有什么问题? 怎么修复.  

```
class CommentsController < ApplicationController
  def users_comments
    posts = Post.all
    comments = posts.map(&:comments).flatten
    @user_comments = comments.select do |comment|
      comment.author.username == params[:username]
    end
  end
end
``` 
