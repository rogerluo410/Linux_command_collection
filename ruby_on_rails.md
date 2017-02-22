#RVM  
* Installing in OSX with homebrew :  
   1. Install Homebrew   
      `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" `      
      `brew doctor` check tool installed successfully.    
   2. Install and configure RVM : 
         ```
         curl -L https://get.rvm.io | bash -s stable    
         source ~/.rvm/scripts/rvm
         ```
   3. Check :  `rvm -v`   
   4. Install Ruby :  `rvm install 2.0.0`
   5. Other command :    
            * `rvm known`   
            * `rvm use 2.0.0`  
            * `rvm list`   
            * `rvm 2.0.0 --default`   
            
   Linux : RVM is not a function, selecting rubies with 'rvm use …' will not work   
   解决办法 : Type `bash --login` from your terminal. And then give rvm use 2.0.0    


#Ruby 语法   
> http://www.runoob.com/ruby/ruby-hash.html   
> http://guides.ruby-china.org/  --rails guides  
> https://en.wikibooks.org/wiki/Category:Ruby_Programming   --

#REST 
REST，或者称为表征状态转移，它是一个分布式通信体系架构，正在迅速发展成云平台的一个通用概念。它非常简单，然而却足以表达大量的云资源和全部的配置、管理。在Ruby中从头开始学习如何实现和使用一个简单的REST代理。
REST是一种web基础通信架构风格，它允许客户端通过一个唯一的值访问服务端。尤其是，REST在给定的服务器里资源作为统一资源标识（URIs），因此在HTTP里简化了REST架构的实现。让我们开始介绍下REST和HTTP背后的一些思想，然后探索下数据表示方法，使用Ruby实现一个简单的REST客户端。   
> http://www.oschina.net/translate/os-understand-rest-ruby  --REST 介绍

#API Description Generator  
> http://apidocjs.com   
> https://github.com/apidoc/apidoc   

#rack-attack  
Rack::Attack is a rack middleware to protect your web app from bad clients.  防止恶意访问。  
> https://github.com/kickstarter/rack-attack   

#代码风格检测  
> https://github.com/bbatsov/rubocop  

#database_cleaner  
Rake task to truncate all tables in Rails   
> http://stackoverflow.com/questions/7755389/rake-task-to-truncate-all-tables-in-rails-3  
> https://github.com/DatabaseCleaner/database_cleaner   


**ruby维护ruby代码？如何保证提交代码的质量？自动化测试程度如何？**  
```
1.https://github.com/bbatsov/rubocop - 代码风格检测
2.https://github.com/presidentbeef/brakeman - 安全检测
3.CI 测试
4.所有改动，走Pull Request的方式，先Review再合并到Master

补充几个在线工具：
https://travis-ci.org/ 在线 CI
https://houndci.com/ 自动检测代码风格，基于 Github
https://linthub.io/ 另一个代码风格检测工具
https://github.com/whitesmith/rubycritic 代码质量监测和报告工具
```

#Rspec   
RSpec is a great tool in the behavior-driven development (BDD) process of writing human readable specifications that direct and validate the development of your application.   
> https://github.com/rspec/rspec-rails  --rspec in rails   
> http://my.oschina.net/huangwenwei/blog/418999   --RSpec入门指南   
> http://www.jianshu.com/p/1db9ee327357  --RSpec入门指南    
> http://betterspecs.org/  --rspec 规范  
> http://chloerei.com/2015/10/26/testing-guide/  --测试指南 
> http://www.relishapp.com/rspec/rspec-rails/v/3-4/docs/gettingstarted  --rspec 文档

目的:  确保你升级各种第三方库或框架的时候，能有保障。    

测试步骤：  
```
整合测试:  
  Controller （不使用stub／mock， 直接使用model层的实体）
  验收测试 （跨controllers测试， 模拟浏览器行为）
  Request （目的是 full-stack测试， 可以stub）
  Featrure

单元测试: 是分层测试， 可使用 rspec-mock / factory-girl 去做隔离
  Model
  Controller (使用stub ／mock)
  View
  Helper
  Routing
  
tips：
  1. 有 time.now 时间依赖的， 用travel_to方法
  2. database_cleaner 资料清洗， 支援不同DB
  3. VCR，Http response重播， 配合 第三方服务
  4. Simplecov 覆盖率
```

```ruby    
它在BDD流程的开发中被用来写高可读性的测试，引导并验证你开发的应用程序。
#常用模式：  
before(:all) { #每段describe执行一次，变量设置为实例变量 @param  } 
before(:each) { #每段it执行一次 } 
after(:all)
after(:each)

describe '描述这个方法的测试目的' do
 let(:arg1) { #做测试使用变量的赋值，lazy memoried, 相较于before(:each)增加执行速度，不需要用 instance variable into before }
 let(:arg2) { #做测试使用变量的赋值 }
 context '描述测试时的上下文环境，它能让测试更清晰，有条理' do
   it "描述测试的功能" do
      #别用should，用expect  (should, expect语句都只能在 it '测试功能描述' do ... end 语句块中使用 )
      #别用fixtures， 用Factory
      #describe '...' do ... end 中定义的变量, 只能在 it '....' do .. end  的块中使用
      expect(actual).to be(expected)    # passes if actual.equal?(expected)
      expect(actual).to equal(expected) # passes if actual.equal?(expected)
      #=> https://github.com/rspec/rspec-expectations  how to use expect  
   end    
 end
end

Instance: 
   describe "PUT /api/v1/team/:team_id/cases/:id/sort" do
    let(:cs) { FactoryGirl.create(:case) }
    let(:case_file_list) { FactoryGirl.create_list(:case_file, 3, case: cs) }
    let(:ids) do
    {
      file_ids: case_file_list.map(&:id).reverse!.join(',')  #逆序排序
    }
    end
    it "returns HTTP status 204, if sort successfully." do
      put "/api/v1/team/#{cs.organization_id}/cases/#{cs.id}/sort", ids

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to have_key("file_keys")
    end
    it "returns HTTP status 403, if organization_id is error." do
      put "/api/v1/team/#{cs.organization_id + 1}/cases/#{cs.id}/sort", ids

      expect(last_response.status).to eq(403)
      expect(JSON.parse(last_response.body)).to have_key("code")
    end
   end

在Factory_girl中: 
FactoryGirl.define do
  factory :case do
    sequence(:name) { |n| "case#{n}" }  
    state             "editing"
    finished_on_year  2015
    finished_on_month 12
    organization_id   63 
  end
end

FactoryGirl.define do
  factory :case_file do
    sequence(:key) { |n| "abc#{n}" } 
    association :case, factory: :case #指定这个关联的真名, strategy: :build #只创建不save这个关联对象
  end
end

##三种model的关联方式
one: 加association, 当FactoryGirl.create(:price_property_option)时, 自动创建关联price_property。 优点是方便， 缺点是只能表示one-to-one关联。  (必须在真实的model中有关联, 否侧会报错)
FactoryGirl.define do
  factory :price_property_option do
    sequence(:name)       { |n| "price_property_option_name#{n}" }
    state "published"
    association :price_property
  end
end

two: 在factory girl 的model定义中 定义回调， 下例中自动创建了关联的files集合。 该方式的优点是可以创建集合关联。
FactoryGirl.define do
  factory :product do
    sequence(:name) { | n | "abc#{n}" }
    state "editing"
    association :goods, factory: :stone_material
    organization_id 63

    after(:create) do |instance|
      instance.files = FactoryGirl.create_list(:product_file, 5)         
    end
  end
end

three: 在测试模块中直接赋值, 而在factory girl 的model定义中不需要定义association关联。
describe "PUT /api/v1/team/:team_id/archives/:id" do
 let(:archive) { FactoryGirl.create(:archive) }
 let(:archive_files) { FactoryGirl.create_list(:archive_file, 5, archive: archive) }
 let(:params) do
 {
   token: @valid_token,
   team_id: @org.id,
   id: archive.id, 
   name: "archive_name_updated",
   file_ids: archive_files.map(&:file_id).reverse!  #逆序
 }
 end
 it "编辑指定组织的指定公司档信息。" do
   put "/api/v1/team/#{params[:team_id]}/archives/#{params[:id]}", params

   expect(last_response.status).to eq(204)
 end

 it "用非法的team_id编辑指定组织的指定公司档信息。" do
   put "/api/v1/team/#{params[:team_id]+1}/archives/#{params[:id]}", params

   expect(last_response.status).to eq(403)
 end
end

##以上是controller的测试模式， model的模式可以使用subject方法。
```

- 使用rspec的一些recipes:   

 1。善用 subject   
如果你有好几个测试都是用了同一个 subject，使用 subject{} 来避免重复, 可以省略receiver。  
```ruby
describe CreditCard do
  subject do
    CreditCard.new name: 'Ann', card_number: 1234
  end
  
  it { should be_valid}
end
```

 2。 当你需要给一个变量赋值时，使用 let 而不是 before 来创建这个实例变量。let 采用了 lazy load 的机制，只有在第一次用到的时候才会加载，然后就被缓存，直到测试结束。  
```ruby
# 这一段:
let(:foo) { Foo.new }

# 基本上和这一段完全等同
def foo
  @foo ||= Foo.new
end

let  and  let!  let第一次调用时赋值， let! 暴力方式赋值，初始化就赋值。
You can read more about this here, but basically. (:let) is lazily evaluated and will never be instantiated if you don't call it, while (:let!) is forcefully evaluated before each method call.

```

 3。当你在描述你的测试的时候，不要使用 should，使用第三人称现在时。更进一步，你可以使用新的 expectation 语法。  
用rspec-expectations的语法做断言！    
```ruby
# gem: https://github.com/rspec/rspec-expectations 
it 'does not change timings' do
  expect(consumption.occur_at).to equal(valid.occur_at)
end
```

 4。 每次你修改了你的项目就要重新跑所有的测试用力真的是一种负担。这会消耗很多时间并且打断了你的工作。 使用 Guard 你可以自动化的运行那些和你正在修改的测试，Model，Controller 或者文件有关的测试。  

 5。 伪装HTTP请求  
有时候你需要用到一些外部的服务。在你不能真的使用这些外部服务的时候你应该用类似 webmock 这样的工具来进行伪装。  

 6。 Use rspec-mocks to stub smoke
 > https://github.com/rspec/rspec-mocks  
 
 7。使用Fuubar   
> https://github.com/thekompanee/fuubar  


#capybara   
Acceptance test framework for web applications   
> https://github.com/jnicklas/capybara    

#Factory_girl  
A library for setting up Ruby objects as test data.  
> https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md   

```ruby
当factory_girl中需要映射 one-many 关联时，可以使用如下写法。  
FactoryGirl.define do
  factory :product do
    sequence(:name) { | n | "abc#{n}" }
    state "editing"
    association :goods, factory: :stone_material
    #association :files, factory: :product_file  #这种方式只能表达1对1关联。 会报错：undefined method `each' for #<ProductFile:0x007f9080441048>
    organization_id 63

    after(:create) do |instance|
      instance.files = FactoryGirl.create_list(:product_file, 5)         
    end
  end
end

```

**遇到多态关联的处理方法**  
不使用factory_girl 的association, 改为在测试脚本中手动关联！
---> archive.update_attributes  
```ruby
 describe "PUT /api/v1/team/:team_id/archives/:id" do
    let(:archive) { FactoryGirl.create(:archive) }
    let(:archive_files) { FactoryGirl.create_list(:archive_file, 5, archive: archive) }
    let(:case_instance) { FactoryGirl.create(:case) }
    let(:sale_certificate) { FactoryGirl.create(:sale_certificate) }
    let(:certificate) { FactoryGirl.create(:certificate) }
    let(:params) do
    {
      token: @valid_token,
      team_id: archive.organization_id,
      id: archive.id, 
      name: "archive_name_updated",
      file_ids: archive_files.map(&:file_id).reverse!,  #逆序
      taxonomy_ids: [1,2,3,4]
    }
    end
    it "123。" do
      put "/api/v1/team/#{params[:team_id]}/archives/#{params[:id]}", params

      expect(last_response.status).to eq(204)
      #expect(archive.archive_files(true)[4].position).to eq 1
    end

    it "456。" do
      archive.update_attributes(:group_id => sale_certificate.id, :group_type => "SaleCertificate")
      put "/api/v1/team/#{params[:team_id]}/archives/#{params[:id]}", params

      expect(last_response.status).to eq(204)
      #expect(archive.archive_files(true)[4].position).to eq 1
    end
    
    
    #不知是factory_girl的bug 或者 ... （非bug, 原因见method3）
    #在用第一种方式做表关联时无效！ 在API的逻辑中查询不到数据。
    #必须 (method 1 + method 3) or (method 0 + method 2)
    describe "GET /api/v1/clients" do
    # method 0
    let(:stranger) { FactoryGirl.create(:stranger) }
    let(:cluster) { FactoryGirl.create(:cluster) }
    let(:client) { FactoryGirl.create(:client) }
    # method 1
    let(:stranger) { FactoryGirl.create(:stranger, user: user_for_stranger, owner: user) }
    let(:cluster) { FactoryGirl.create(:cluster, user: user) }
    let(:client) { FactoryGirl.create(:client, cluster: cluster, stranger: stranger) }
    let(:params) do       
    {
      token: user.authentication_token,
      cluster_id: cluster.id.to_s
    }
    end
    it "全量查询指定组织的客户列表" do
      # method 2
      stranger.update_attributes(user_id: user_for_stranger.id, owner_id: user.id)
      cluster.update_attributes(user_id: user.id)
      client.update_attributes(cluster_id: cluster.id, stranger_id: stranger.id)
      
      # method 3 
      使用reload是因为在FactoryGirl.define中定义映射model的对象时，使用了关联association 关联其他对象, 导致在rspec中手动关联的数据没有刷入数据库中，手动关联无效，所以必须reload一下。
      stranger.reload
      cluster.reload
      client.reload
      get "/api/v1/clients", params

      data = JSON.parse(response.body)

      p data
      p user
      p stranger
      p stranger.user
      p cluster
      p client
      p params
      expect(response.status).to eq(200)
      expect(data).to have_key("clients")
    end
    
    #业务模型多场景的定义方法 
    #在定义factorygirl映射某个模型时，可以定义多个factorygirl对象来表示对象在不同场景下的状态。
    FactoryGirl.define do
     factory :stranger do
       user_id nil
       sequence(:name)        { |n| "name#{n}" }
       sequence(:pinyin_name) { |n| "name#{n}" }
       sequence(:email)       { |n| "email#{n}@stranger.com" }
       level 0
       group "normal"
       association :owner, factory: :user
   
       trait :unsign do
         user_id nil
       end
   
       factory :stranger_signed do
         association :user
       end
   
       factory :stranger_with_clusters do
   
         transient do
           clusters_count 5
         end
   
         after(:create) do |stranger, evaluator|
           stranger.clusters = create_list(:cluster, evaluator.clusters_count)
         end
   
       end
   
       factory :stranger_with_contacts do
   
         transient do
           contacts_count 1
           contact_params nil
         end
   
         after(:create) do |stranger, evaluator|
           if evaluator.contact_params.nil?
             stranger.contacts = create_list(:contact_mobile, evaluator.contacts_count)
           else
             stranger.contacts = create_list(:contact, evaluator.contacts_count, content: evaluator.contact_params[:content], clazz: evaluator.contact_params[:clazz])
           end
         end
        end
       end
      end
```

- rspec-expectation 的一些用法  
> https://github.com/rspec/rspec-expectations  

```
expect(actual).to eq(expected)  # passes if actual == expected
expect(actual).to eql(expected) # passes if actual.eql?(expected)
expect(actual).not_to eql(not_expected) # passes if not(actual.eql?(expected))

expect(actual).to be(expected)    # passes if actual.equal?(expected)
expect(actual).to equal(expected) # passes if actual.equal?(expected)  


expect(actual).to be_truthy   # passes if actual is truthy (not nil or false)
expect(actual).to be true     # passes if actual == true
expect(actual).to be_falsy    # passes if actual is falsy (nil or false)
expect(actual).to be false    # passes if actual == false
expect(actual).to be_nil      # passes if actual is nil
expect(actual).to_not be_nil  # passes if actual is not nil
```

#Guard     
使用 Guard 你可以自动化的运行那些和你正在修改的测试，Model，Controller 或者文件有关的测试。    
> https://github.com/guard/guard     

#rack-mini-profiler  
Middleware that displays speed badge for every html page. Designed to work both in production and in development.  
页面应用响应时间  
> https://github.com/MiniProfiler/rack-mini-profiler  

#EventMachine-scalable-non-blocking IO  
EventMachine is an event-driven I/O and lightweight concurrency library for Ruby.   
> https://github.com/eventmachine/eventmachine   
> http://www.scribd.com/doc/28253878/EventMachine-scalable-non-blocking-i-o-in-ruby   

并发框架:  
> https://github.com/ruby-concurrency/concurrent-ruby  
> https://github.com/puma/puma  
> https://github.com/celluloid/celluloid  

#Mina  
Really fast deployer and server automation tool.  自动化部署rails环境    
> https://github.com/mina-deploy/mina   
> http://yafeilee.me/blogs/5550f3006c693403675a0000   --使用案例  

#state_machine   
Adds support for creating state machines for attributes on any Ruby class   
> https://github.com/pluginaweek/state_machine

#spork    
加上这个gem后，simplecov统计代码覆盖率时才能将API接口的代码统计进去。       
> https://github.com/sporkrb/spork   

#devise    
Flexible authentication solution       
> https://github.com/plataformatec/devise    

**Use Devise + cancancan**  
> http://stackoverflow.com/questions/34962815/devise-and-cancancan-how-to-make-it-work   

**rails generate devise:views 默认是erb, 怎么转换成slim**  
> https://github.com/plataformatec/devise/wiki/How-To%3a-Create-Haml-and-Slim-Views  

**ActionController::InvalidAuthenticityToken in RegistrationsController#create 遇到这类错误的解决方法**  
> http://stackoverflow.com/questions/20875591/actioncontrollerinvalidauthenticitytoken-in-registrationscontrollercreate 

```ruby
#自定义继承devise的controller, 并在app/controllers/users/registrations_controller.rb 中过滤掉token验证
class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token, :only => :create
end

#在路由中重载controller路径
devise_for :users, :controllers => { :sessions => "users/sessions", :registrations => "users/registrations" }
```

**Ruby on Rails中实现Omniauth第三方登录最终解决方案（豆瓣、QQ、微博第三方登录）**    
> http://www.douban.com/note/411359006/  
> https://github.com/fertapric/rails3-mongoid-devise-omniauth  

#sidekiq
后台任务池   
> https://github.com/mperham/sidekiq   

#cancan    
CanCan is an authorization library for Ruby on Rails which restricts what resources a given user is allowed to access.    
> https://github.com/ryanb/cancan    
> https://github.com/CanCanCommunity/cancancan

#mime-types    
The mime-types library provides a library and registry for information about MIME content type definitions.    
> https://github.com/mime-types/ruby-mime-types   

#redis-objects   
Map Redis types directly to Ruby objects  
> https://github.com/nateware/redis-objects   

#redis-rb   
A Ruby client library for Redis    
> https://github.com/redis/redis-rb   

#mock_redis   
Mock Redis gem for Ruby   
> https://github.com/brigade/mock_redis   

#responders   
A set of responders modules to dry up your Rails   
> https://github.com/plataformatec/responders   

#acts_as_tree   
ActsAsTree -- Extends ActiveRecord to add simple support for organizing items into parent–children relationships.  
> https://github.com/amerine/acts_as_tree   

#will_paginate 分页  
> https://github.com/mislav/will_paginate     
> https://github.com/amatsuda/kaminari   
> https://github.com/lucasas/will_paginate_mongoid   --mongoid的model的分页  

#Rails with mongoDB
Using gem **mongoid**   
```
As far as I am concerned you will have to create a new Rails project excluding active record:

rails new my_app --skip-active-record
then you can follow the configuration steps from Mongoid:

http://mongoid.org/en/mongoid/docs/installation.html
```

#carrierwave 
文件上传器
Classier solution for file uploads for Rails, Sinatra and other Ruby web frameworks   
> https://github.com/carrierwaveuploader/carrierwave   

###rails + mongoid + carrierwave 实现图片上传的案例   
使用的gems:   
> https://github.com/carrierwaveuploader/carrierwave   --获得上传的文件对象
> https://github.com/carrierwaveuploader/carrierwave-mongoid   --将文件对象存入mongodb的gridfs中
> https://github.com/ahoward/mongoid-grid_fs    --通过查询参数获得mongodb的gridfs中的文件对象   
> https://github.com/meskyanichi/mongoid-paperclip  --灵活处理上传的文件  

相关文档:   
> https://docs.mongodb.org/manual/core/gridfs/   --gridfs介绍  

上传案例: 
> https://coderwall.com/p/lqtsya/rails-3-mongoid-gridfs-carrierwave-image-upload  
> https://hafizbadrie.wordpress.com/2011/04/14/image-upload-with-carrierwave-and-mongoid-gridfs-mongodb-in-rails-3/  

#settingslogic  
A simple and straightforward settings solution that uses an ERB enabled YAML file and a singleton design pattern.  
> https://github.com/binarylogic/settingslogic    

#webmock
Library for stubbing and setting expectations on HTTP requests in Ruby.   
简单说就是你可以用stub去伪造(fake)一个方法,阻断对原来方法的调用   
stub是伪造方法， mock是伪造对象    
> https://github.com/bblimke/webmock  

#vcr  
VCR is also an amazing Ruby gem that records your test suite's HTTP interactions and replays them during future test runs.
它可以降低测试时web分布式组件之间的耦合度，加速测试速度。  
> https://github.com/vcr/vcr  
> http://www.thegreatcodeadventure.com/stubbing-with-vcr/   --use webmock + vcr  
> http://qiita.com/xiangzhuyuan/items/9f3301cd30e09369e7d1  --创建假的服务api路由一定要写对， 否则模拟失败。  
> https://ruby-china.org/topics/26588  --使用 Webmock 和 VCR 搭建测试，对调用第三方 API 库的支持(本地fake第三方api, 不需要使用vcr的replay功能)   

#Cache
###record-cache   
Cache Active Model Records in Rails 3   
> https://github.com/orslumen/record-cache   

###simple_cacheable   
Simple Cacheable is a simple cache implementation based on activerecord  
> https://github.com/flyerhzm/simple_cacheable

###identity_cache
IdentityCache is a blob level caching solution to plug into ActiveRecord. Don't #find, #fetch!  
> https://github.com/Shopify/identity_cache  

###second_level_cache  
SecondLevelCache is a write-through and read-through caching library inspired by Cache Money and cache_fu, support ActiveRecord 4.

Read-Through: Queries by ID, like current_user.articles.find(params[:id]), will first look in cache store and then look in the database for the results of that query. If there is a cache miss, it will populate the cache.

Write-Through: As objects are created, updated, and deleted, all of the caches are automatically kept up-to-date and coherent.
> https://github.com/hooopo/second_level_cache

----------------------------------

#Rails   
> http://api.rubyonrails.org  --查询rails API   
> http://www.rubydoc.info  --查询GEMS文档  
> http://guides.rubyonrails.org/active_record_validations.html  --active model validations   
> http://guides.rubyonrails.org/active_record_querying.html     --active record querying  
> http://guides.rubyonrails.org/active_record_callbacks.html    --active record callbacks   
> http://edgeguides.rubyonrails.org/active_record_migrations.html  --active record migrations  
> http://guides.rubyonrails.org/association_basics.html  --active record association  
> https://www.rubyplus.com/articles  --rails cast  
> https://www.ruby-toolbox.com/#Web_Apps_Services_Interaction  --rails gems分类  
> http://blog.58share.com/?p=232   --rails的框架结构与常用配置  

###String In Active Support:   
> http://guides.ruby-china.org/active_support_core_extensions.html   

```
as_json
classify
constantize
humanize
tableize
```

- 说说 ruby 里的 hash 和 ActiveSupport 里的 HashWithIndifferentAccess 的区别?    
`Implements a hash where keys :foo and "foo" are considered to be the same.`
:foo 和 "foo" 为相同的key，在HashWithIndifferentAccess中。  

###In Model: 
   * validates : Validations are used to ensure that only valid data is saved into your database.  
     只有在`create,create!,save,save!,update,update!`做持久化时才会触发，当对象存在，可以用valid?方法验证对象，   `save(validate: false)` 能跳过验证.  
     如果验证失败，错误信息会存放在对象的errors[]集合中`taxonomy.errors.full_messages.join(",") `
```
       1. presence   
       eg.
        validates :name, presence :true   
        Person.create(name: "John").valid?  => true  
        Person.create(name: nil).valid?     => false   
        Person.new(name: "John").new_record?  =>true     
        
       2. acceptance: This validation is very specific to web applications and this 'acceptance' does not need to be recorded anywhere in your database (if you don't have a field for it, the helper will just create a virtual attribute).       
       eg.  
        validates :terms_of_service, acceptance: true    
        validates :terms_of_service, acceptance: { accept: 'yes'}    
    
       3. validates_associated       
      class Library < ActiveReord::Base  
        has_many :books   
        validates_associated :books  #不需要在book类中再加验证，否则会infinite loop    
                                     #如果验证错误，book对象会有自己的errors collection，不会bubble up到library对象的errors中    
      end   
      
       4. confirmation: 验证confirm时有用     
       validates :email, confirmation: true    
  
       5. exclusion: 值域不在指定的集合中    
       validates :subdomain, exclusion: { in: %w(www us ca jp), message: "%{value} is reserved"}    
       
       #Since false.blank? is true, if want to validate the presence of a boolean field, should use like below:    
       validates :boolean_field_name, presence: true  
       validates :boolean_field_name, inclusion: { in: [true,false]}  
       validates :boolean_filed_name, exclusion: { in: [nil]}   
  
       6. format: 通过正则去验证值域的格式     
       validates :legacy_code, format: { with: /\A[a-zA-Z]+\z/, message: "Only allows letters"}   
      
       7. length   
       validates :name, length: { minimum: 2, too_short: "must have at least %{count} words"}  
       validates :bio, length: {maximum: 500, too_long: "must have at most %{count} words"}  
       validates :password, length:{ in: 6..20}  
       validates :number, length:{is: 6}  
       
       8. numericality   
       validates :points, numericality: true   #值域只能是整型或浮点  
       validates :points, numericality: {only_integer: true}  #值域只能是整型   
  
       9. uniqueness: 唯一性验证，表中该字段是否存在相同的值域，做持久化时才生效   
        validates :name, uniqueness: true    
     
        #scope option 可以同时验证其他字段的唯一性    
        validates :name, uniqueness: { scope: :year, message: "should happen once per year"}    
        
        #排除大小写敏感   
        validates :name, uniqueness: {case_sensitive: false}   
        
        10. validates_with, validates_each  
        
        **Common validation Options for validations:
        eg.
         validates :size, inclusion: { in: %w(small medium), message: "..."}, allow_nil: true 
         
         allow_nil
         allow_blank
         message
         on   ==>  validates :age, numericality: true, on: :update  #仅在update时验证  
         strict validations  ==> validates :name, presence: {strict: true}
                             ==> Person.new.valid?  #=> ActiveModel::StrictValidationFailed: Name can't br blank   
                            
         条件验证  if:  unless: 
         ==> validates :card_number, presence: true, if: :paid_with_card?   
             def paid_with_card?
                 payment_type == "card"  
             end
```
     
     
   * callbacks: With callbacks it is possible to write code that will run whenever an `Active Record object` is created, saved, updated, deleted, validated, or loaded from the database.  
```
#Implement the callbacks as ordinary methods and use a marco-style class method to register them as callbacks. 
#Meanwhile, we can register callbacks with a block. 

    1.before_validation :ensure_login_has_a_value
      protected  #回调函数最好定义为protected or private, 以免破坏类的封装性.   
         def ensure_login_has_a_value
             ...
         end
         
      before_validation do
          ...
      end
      
      after_validation :set_location, on: [:create, :update]
-------------------------------------------------------------------------      
      before_save
      around_save
      after_save
      before_create
      around_create
      after_create
      before_update
      around_update
      after_update
      before_destroy
      around_destroy
      after_destroy
      after_commit/after_rollback
      after_initialize    #=> new 之后会触发
      after_find          #=> all, first, find, find_by, find_by_*, find_by_*!, find_by_sql, last之后会触发  
      after_touch  
      
      #Skipping Callbacks
      decrement
      decrement_counter
      delete
      delete_all
      increment
      increment_counter
      toggle
      touch
      update_column
      update_columns
      update_all
      update_counters
      
      #Halting
      As you start registering new callbacks for your models, they will be queued for execution. 
      This queue will include all your model's validations, the regsitered callbacks, and the database operation to be executed.
      整个回调链包含在一个事务中。如果任何一个 before_* 回调方法返回 false 或抛出异常，整个回调链都会终止执行，撤销事务；而 after_* 回调只有抛出异常才能达到相同的效果。   

      #Conditional Callbacks
      before_save :normalize_card_number, if: :paid_with_card?  
      
      #Callback Classes
      Sometimes the callback methods that you'll write will be useful enough to be reused by other models.
```
   * 对象关联- association  
使用new方法创建的对象：   
```
 product = Product.new( name: "da", organization_id: 63 )
 => #<Product id: nil, name: "da", state: "editing", organization_id: 63, goods_id: nil, goods_type: nil, created_at: nil, updated_at: nil, description: nil> 
2.1.4 :006 > product.product_property_values.build(custom_value: "123", product_property_id: 4)
 => #<ProductPropertyValue id: nil, custom_value: "123", product_id: nil, product_property_id: 4, created_at: nil, updated_at: nil> 
2.1.4 :007 > product.save
   (0.3ms)  BEGIN
  SQL (3.1ms)  INSERT INTO "products" ("name", "organization_id", "state", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["name", "da"], ["organization_id", 63], ["state", "editing"], ["created_at", "2016-04-06 08:41:27.055093"], ["updated_at", "2016-04-06 08:41:27.055093"]]
  SQL (2.6ms)  INSERT INTO "product_property_values" ("custom_value", "product_property_id", "product_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["custom_value", "123"], ["product_property_id", 4], ["product_id", 21], ["created_at", "2016-04-06 08:41:27.069264"], ["updated_at", "2016-04-06 08:41:27.069264"]]
   (3.4ms)  COMMIT

说明在没有id时，也可以进行关联。  
```

`accepts_nested_attributes_for` with multiple nesting：  
> http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html#method-i-accepts_nested_attributes_for  
> http://stackoverflow.com/questions/30443812/accepts-nested-attributes-for-with-multiple-nesting-and-polymorphic-association  

Nested attributes allow you to save attributes on associated records `through the parent`（类定义中有has_one/has_many的是父对象）. By default nested attribute updating is `turned off`(除非直接用子对象去访问修改！) and you can enable it using the #accepts_nested_attributes_for class method. When you enable nested attributes an attribute writer is defined on the model.  

```ruby
  class Product < ActiveRecord::Base
  include ApiRequest
  validates :organization_id, presence: true
  validates :name, presence: true

  belongs_to :goods, polymorphic: true, dependent: :destroy

  has_many :prices, dependent: :destroy, inverse_of: :product
  has_many :archive_associations, dependent: :destroy
  has_many :files, dependent: :destroy, class_name: "ProductFile"
  has_many :archives, through: :archive_associations
  has_many :product_property_values, dependent: :destroy

  accepts_nested_attributes_for :goods
  accepts_nested_attributes_for :prices, allow_destroy: true
  accepts_nested_attributes_for :archive_associations, allow_destroy: true
  accepts_nested_attributes_for :files, allow_destroy: true
  accepts_nested_attributes_for :product_property_values, allow_destroy: true
  ...
  
  usage: 主要用于has_many/has_one关联， 在一个事务中修改关联的属性。
  
  In class Product, has methods goods_attributes= [ { id: 1 ,attr1: value, attr2: value }, { id: 2 ,attr1: value, attr2: value } ], prices_attributes=, archive_associations_attributes=, files_attributes=, product_property_values_attributes=  
  if has_one, the method is like this: price_attributes= { },  file_attributes= { attr1: value, attr2: value }   
  
  Product的实例也有 attributes方法, product.attributes=  { ... } : 
   product = Product.find(params[:id])
   if params[:name].present?
     file = product.files.find_by(file_id: params[:file_id])
     name_attribute = { files_attributes: [ {id: file.id, name: params[:name]} ] }
     product.attributes = name_attribute
   end
   
   关联对象attributes方法的用法(在product对象的实例方法中)： 
   send("files_attributes=", self.files.map { |f| { :id => f.id, :position => index_dict[f.file_id.to_s] }
  
   send("product_property_values_attributes=", self.product_property_values.where.not(product_property_id: properties.keys).map { | property_value | {:id => property_value.id, "_destroy" => true} } ) 
   
   #修改
   update_list = properties.keys.map do | property_id |
     if self.product_property_values.exists?(product_property_id: property_id) and self.product_property_values.find_by!(product_property_id: property_id).custom_value != properties[property_id]
       { 
         :id => self.product_property_values.find_by!(product_property_id: property_id).id,
         :custom_value => properties[property_id]
       }
     end
   end
   send("product_property_values_attributes=", update_list.compact)  

```

**`collection_singular_ids` 的细节**     
```
#<ActiveRecord::Associations::CollectionProxy [#<JobseekerZone id: 203, jobseeker_id: 78, zone_id: 10016, created_at: "2016-04-13 03:27:38", updated_at: "2016-04-13 03:27:38">, #<JobseekerZone id: 204, jobseeker_id: 78, zone_id: 10017, created_at: "2016-04-13 03:27:38", updated_at: "2016-04-13 03:27:38">, #<JobseekerZone id: 205, jobseeker_id: 78, zone_id: 10018, created_at: "2016-04-13 03:27:38", updated_at: "2016-04-13 03:27:38">, #<JobseekerZone id: 206, jobseeker_id: 78, zone_id: 198, created_at: "2016-04-13 03:27:38", updated_at: "2016-04-13 03:27:38">, #<JobseekerZone id: 207, jobseeker_id: 78, zone_id: 199, created_at: "2016-04-13 03:27:38", updated_at: "2016-04-13 03:27:38">, #<JobseekerZone id: 208, jobseeker_id: 78, zone_id: 200, created_at: "2016-04-13 03:27:38", updated_at: "2016-04-13 03:27:38">]>

zone_ids == [203, 204, 205, 206, 207, 208] 

collection_singular_ids=ids
collection_singular_ids= 方法让数组中只包含指定的主键，根据需要增删ID。  
```

**`belongs_to` 关联添加的方法**    
声明  belongs_to 关联后，所在的类自动获得了五个和关联相关的方法：   
```
association(force_reload = false)
association=(associate)
build_association(attributes = {})
create_association(attributes = {})
create_association!(attributes = {})
```  
这五个方法中的 association 要替换成传入 belongs_to 方法的第一个参数。例如，如下的声明：   
```ruby
class Order < ActiveRecord::Base
  belongs_to :customer
end

每个 Order 模型实例都获得了这些方法：  
customer
customer=
build_customer
create_customer
create_customer!

在 has_one 和 belongs_to 关联中，必须使用 build_* 方法构建关联对象。association.build 方法是在 has_many 和 has_and_belongs_to_many 关联中使用的!

```

**`has_many `关联添加的方法**       
```
声明 has_many 关联后，声明所在的类自动获得了 16 个关联相关的方法：

collection(force_reload = false)
collection<<(object, ...)
collection.delete(object, ...)
collection.destroy(object, ...)
collection=objects
collection_singular_ids
collection_singular_ids=ids
collection.clear
collection.empty?
collection.size
collection.find(...)
collection.where(...)
collection.exists?(...)
collection.build(attributes = {}, ...)
collection.create(attributes = {})
collection.create!(attributes = {})
```

**关联时出现重复记录的情况, 查询条件中有 IN谓词的要注意!**   
```ruby
解决方法：
jobseekers.joins(:zones).where("jobseeker_zones.zone_id in (?)", params[:zone_ids] ).distinct

错误实例：
Jobseeker.joins(:zones).where("jobseeker_zones.zone_id in (?)", [1,2] )
  Jobseeker Load (4.2ms)  
  SELECT "jobseekers".* FROM "jobseekers" 
  INNER JOIN "jobseeker_zones" ON "jobseeker_zones"."jobseeker_id" = "jobseekers"."id" 
  WHERE (jobseeker_zones.zone_id in (1,2))
  
 => #<ActiveRecord::Relation [
 #<Jobseeker id: 1, rate: 10, state: "published", role_id: 26, vocation_id: 1, user_id: 4, created_at: nil, updated_at: nil>, 
 #<Jobseeker id: 1, rate: 10, state: "published", role_id: 26, vocation_id: 1, user_id: 4, created_at: nil, updated_at: nil>]>   #两条一样的记录

2.1.4 :056 >   Jobseeker.joins(:zones).where("jobseeker_zones.zone_id in (?)", [1,2] ).distinct
  Jobseeker Load (5.9ms)  
  SELECT DISTINCT "jobseekers".* FROM "jobseekers" 
  INNER JOIN "jobseeker_zones" ON "jobseeker_zones"."jobseeker_id" = "jobseekers"."id" 
  WHERE (jobseeker_zones.zone_id in (1,2))
 => #<ActiveRecord::Relation [#<Jobseeker id: 1, rate: 10, state: "published", role_id: 26, vocation_id: 1, user_id: 4, created_at: nil, updated_at: nil>]> 
 
 
执行复杂计算时还可使用各种查询方法：

Client.includes("orders").where(first_name: 'Ryan', orders: { status: 'received' }).count
上述代码执行的 SQL 语句如下：

SELECT count(DISTINCT clients.id) AS count_all FROM clients
  LEFT OUTER JOIN orders ON orders.client_id = client.id WHERE
  (clients.first_name = 'Ryan' AND orders.status = 'received')

```
 


###In CRUD  
> http://guides.ruby-china.org/active_record_basics.html  

- create   返回对象 或 nil  
- create!   返回对象 或 抛出异常  
- save     返回 true 或 false    
- save!    返回 true 或 抛出异常    
- update   返回true 或 false    
- update_attributes 返回true 或 false  
- destroy  返回对象 或 nil    
- destroy! 返回对象 或 抛出异常   

###In Controller  
**router - 路由**  
```
resources :posts do
  member do
    get 'comments'
  end               #成员路由 posts/:id/comments
  collection do
    post 'bulk_upload'
  end               ＃集合路由 posts/bulk_upload
end
```  
有几个路由地址：9条  
```
comments_post GET      /posts/:id/comments(.:format)           posts#comments   
bulk_upload_posts POST     /posts/bulk_upload(.:format)        posts#bulk_upload   
posts GET    /posts(.:format)                        posts#index  
    POST     /posts(.:format)                        posts#create  
    GET      /posts/new(.:format)                    posts#new  
    GET      /posts/:id/edit(.:format)               posts#edit  
    GET      /posts/:id(.:format)                    posts#show  
    PATCH    /posts/:id(.:format)                    posts#update  
    PUT      /posts/:id(.:format)                    posts#update  
    DELETE   /posts/:id(.:format)                    posts#destroy    
```    

- 添加集合路由的方式如下(后缀路由)：  
```
resources :photos do
  collection do
    get 'search'
  end
end  

这段路由能识别 /photos/search 是个 GET 请求，映射到 PhotosController 的 search 动作上。同时还会生成 search_photos_url 和 search_photos_path 两个帮助方法。  
```  

- 前缀路由:  
```
scope 'admin', as: 'admin' do
  resources :photos, :accounts
end
 
resources :photos, :accounts  

scope ':username' do
  resources :articles
end
这段路由能识别 /bob/articles/1 这种请求，在控制器、帮助方法和视图中可使用 params[:username] 获取 username 的值。  
```  

- 限制生成的路由:  
默认情况下，Rails 会为每个 REST 路由生成七个默认动作（index，show，new，create，edit，update 和 destroy）对应的路由。你可以使用 :only 和 :except 选项调整这种行为。:only 选项告知 Rails，只生成指定的路由：  
```
resources :photos, only: [:index, :show]  
```
- 单条资源的路由: 
```ruby
Singular Resources: 

resource :geocoder 

HTTP Verb	Path	      Controller#Action	Used for
GET	   /geocoder/new	geocoders#new	   return an HTML form for creating the geocoder
POST	   /geocoder	   geocoders#create	create the new geocoder
GET	   /geocoder	   geocoders#show	   display the one and only geocoder resource
GET	   /geocoder/edit	geocoders#edit	   return an HTML form for editing the geocoder
PATCH/PUT  /geocoder	   geocoders#update	update the one and only geocoder resource
DELETE	  /geocoder	   geocoders#destroy	delete the geocoder resource
```

- CSRF 是什么, Rails 里针对它做了些什么?   
所有使用表单帮助方法生成的表单，都有会添加这个令牌。如果想自己编写表单，或者基于其他原因添加令牌，可以使用
form_authenticity_token 方法。

```
跨站请求伪造（CSRF）是一种攻击方式，A网站的用户伪装成B网站的用户发送请求，
在B站中添加、修改或删除数据，而B站的用户绝然不知。

防止这种攻击的第一步是，确保所有析构动作(create，update 和 destroy)只能通过GET之外的请求方法访问。
如果遵从REST架构，已经完成了这一步。不过，恶意网站还是可以很轻易地发起非GET请求，
这时就要用到其他防止跨站攻击的方法了。

我们添加一个只有自己的服务器才知道的难以猜测的令牌。如果请求中没有该令牌，就会禁止访问。
```

- ActionDispatch类 处理所有请求中的元素。    

```
ActionDispatch::Session::CookieStore：所有数据都存储在客户端
ActionDispatch::Session::CacheStore：数据存储在 Rails 缓存里
ActionDispatch::Session::ActiveRecordStore：使用 Active Record 把数据存储在数据库中（需要使用 activerecord-session_store gem）
ActionDispatch::Session::MemCacheStore：数据存储在 Memcached 集群中（这是以前的实现方式，现在请改用 CacheStore）
```

- 过滤器（filter）是一些方法，在控制器动作运行之前、之后，或者前后运行。   

- request 和 response 对象    

- 数据流和文件下载   

- 异常处理 与 rescue_from  


###In View: 
文本中的\r\n 转换为html中的标签<br/>换行符: 
> http://api.rubyonrails.org/classes/ActionView/Helpers/TextHelper.html
> http://stackoverflow.com/questions/3137393/rails-add-a-line-break-into-a-text-area

```
Line breaks in textareas are produced as `\n'. However, the problem is that if you simply dump it into your view, it will just be line breaks in your HTML source.

You can try using the Rails simple_format helper to take care of some of this for you: http://api.rubyonrails.org/classes/ActionView/Helpers/TextHelper.html#M002285

It will auto-convert line breaks to HTML tags. You can use it with something like <%= simple_format(my_text_field) %>.
```

**rails中缓存的使用**  
> http://hawkins.io/2011/05/advanced_caching_in_rails/     
> http://hawkins.io/2012/07/advanced_caching_revised/   
> https://ruby-china.org/topics/19389  --总结 Web 应用中常用的各种 Cache   
> http://guides.ruby-china.org/caching_with_rails.html  --Rails 缓存简介  
> http://robbinfan.com/blog/38/orm-cache-sumup  --Web应用的缓存设计模式

cache是提高应用性能重要的一个环节, 动态内容的cache有如下几种。
文章以Nginx，Rails，Mysql，Redis作为例子，换成其他web服务器，语言，数据库，缓存服务都是类似的。  

- 客户端缓存   

- Nginx缓存     

- 整页缓存（页面缓存）  
 页面缓存机制允许网页服务器（Apache 或 Nginx 等）直接处理请求，不经 Rails 处理。这么做显然速度超快，但并不适用于所有情况（例如需要身份认证的页面）。服务器直接从文件系统上伺服文件，所以缓存过期是一个很棘手的问题。

- 片段缓存   
片段缓存把视图逻辑的一部分打包放在 cache 块中，后续请求都会从缓存中返回这部分内容。  
```
<% cache do %>
  All available products:
  <% Product.all.each do |p| %>
    <%= link_to p.name, product_url(p) %>
  <% end %>
<% end %>

上述代码中的 cache 块会绑定到调用它的动作上，输出到动作缓存的所在位置。因此，如果要在动作中使用多个片段缓存，就要使用 action_suffix 为 cache 块指定前缀：  

<% cache(action: 'recent', action_suffix: 'all_products') do %>
  All available products:  
  
expire_fragment 方法可以把缓存设为过期，例如：  
expire_fragment(controller: 'products', action: 'recent', action_suffix: 'all_products')  

如果不想把缓存绑定到调用它的动作上，调用 cahce 方法时可以使用全局片段名：  
<% cache('all_available_products') do %>
  All available products:
<% end %>   

在 ProductsController 的所有动作中都可以使用片段名调用这个片段缓存，而且过期的设置方式不变：  
expire_fragment('all_available_products')  
```

- 底层缓存   
> http://stackoverflow.com/questions/8915814/cache-strategy-for-rails-where-new-objects-appearing-invalidates-the-cache  
> http://stackoverflow.com/questions/12718759/ruby-on-rails-caching-variables  
实现底层缓存最有效地方式是使用 Rails.cache.fetch 方法。这个方法既可以从缓存中读取数据，也可以把数据写入缓存。  
传入单个参数时，读取指定键对应的值。传入代码块时，会把代码块的计算结果存入缓存的指定键中，然后返回计算结果。     
```
class Product < ActiveRecord::Base
  def competing_price
    Rails.cache.fetch("#{cache_key}/competing_price", expires_in: 12.hours) do
      Competitor::API.find_price(id)
    end
  end
end

注意，在这个例子中使用了 cache_key 方法，所以得到的缓存键名是这种形式：products/233-20140225082222765838000/competing_price。cache_key 方法根据模型的 id 和 updated_at 属性生成键名。这是最常见的做法，因为商品更新后，缓存就失效了。一般情况下，使用底层缓存保存实例的相关信息时，都要生成缓存键。
```

- 数据查询缓存 （底层缓存）  
查询缓存是 Rails 的一个特性，把每次查询的结果缓存起来，如果在同一次请求中遇到相同的查询，直接从缓存中读取结果，不用再次查询数据库。  

- 跨请求周期的缓存（底层缓存）   

- 缓存的存储方式  
是存在内存中，还是磁盘上，还是缓存中间件上。这些是可以选择的。  
Rails 为动作缓存和片段缓存提供了不同的存储方式。 页面缓存全部存储在硬盘中。  




**关联查询以及预加载**  
> https://ruby-china.org/topics/22192   --ActiveRecord 的三种数据预加载形式 - includes, preload, eager_load   

预加载的使用场景是， 主对象集合查询出来的数据，需要去访问关联的对象数据， 这时可以使用预加载。 以提高对象访问速度。  

includes:  
```
ProductPropertyGroup.includes(:product_properties).where(id: 1)
  ProductPropertyGroup Load (2.4ms)  SELECT "product_property_groups".* FROM "product_property_groups" WHERE "product_property_groups"."id" = $1  [["id", 1]]
  ProductProperty Load (1.2ms)  SELECT "product_properties".* FROM "product_properties" WHERE "product_properties"."product_property_group_id" IN (1)
 => #<ActiveRecord::Relation [#<ProductPropertyGroup id: 1, name: "g1", position: 1, state: "published", aliaz: "g1", service_id: 4, created_at: "2016-03-21 00:00:00", updated_at: "2016-03-21 00:00:00">]> 
 
 ProductPropertyGroup.includes(:product_properties)
  ProductPropertyGroup Load (3.3ms)  SELECT "product_property_groups".* FROM "product_property_groups"
  ProductProperty Load (1.0ms)  SELECT "product_properties".* FROM "product_properties" WHERE "product_properties"."product_property_group_id" IN (1, 2)
 => #<ActiveRecord::Relation [#<ProductPropertyGroup id: 1, name: "g1", position: 1, state: "published", aliaz: "g1", service_id: 4, created_at: "2016-03-21 00:00:00", updated_at: "2016-03-21 00:00:00">, #<ProductPropertyGroup id: 2, name: "g2", position: 2, state: "published", aliaz: "g2", service_id: 4, created_at: "2016-03-21 00:00:00", updated_at: "2016-03-21 00:00:00">]> 
 
 如果没加查询条件， 关联查询则会全量兜取出来，并存放入主对象的ActiveRecord::Associations::CollectionProxy中，
 所以， 要注意主对象集合加限制条件， 不然关联对象集合会全量导入内存中， 反而影响效率。 
```

preload:  
与 includes差不多， 但是， 如果查询条件中是关联对象的字段，则会报错，
而在使用 includes时， 则会转换成eager_load. 即变成left join的关联查询方式。 
```
ProductPropertyGroup.eager_load(:product_properties).where(id: 1)
  SQL (0.6ms)  SELECT "product_property_groups"."id" AS t0_r0, "product_property_groups"."name" AS t0_r1, "product_property_groups"."position" AS t0_r2, "product_property_groups"."state" AS t0_r3, "product_property_groups"."aliaz" AS t0_r4, "product_property_groups"."service_id" AS t0_r5, "product_property_groups"."created_at" AS t0_r6, "product_property_groups"."updated_at" AS t0_r7, "product_properties"."id" AS t1_r0, "product_properties"."name" AS t1_r1, "product_properties"."position" AS t1_r2, "product_properties"."state" AS t1_r3, "product_properties"."aliaz" AS t1_r4, "product_properties"."product_property_group_id" AS t1_r5, "product_properties"."created_at" AS t1_r6, "product_properties"."updated_at" AS t1_r7 FROM "product_property_groups" LEFT OUTER JOIN "product_properties" ON "product_properties"."product_property_group_id" = "product_property_groups"."id" WHERE "product_property_groups"."id" = $1  [["id", 1]]
 => #<ActiveRecord::Relation [#<ProductPropertyGroup id: 1, name: "g1", position: 1, state: "published", aliaz: "g1", service_id: 4, created_at: "2016-03-21 00:00:00", updated_at: "2016-03-21 00:00:00">]> 
 
 
 ProductPropertyGroup.includes(:product_properties).where("product_properties.name = ?", "n1").references(:product_properties)  -- 关联的表需要加 references(:product_properties)  
  SQL (6.9ms)  SELECT "product_property_groups"."id" AS t0_r0, "product_property_groups"."name" AS t0_r1, "product_property_groups"."position" AS t0_r2, "product_property_groups"."state" AS t0_r3, "product_property_groups"."aliaz" AS t0_r4, "product_property_groups"."service_id" AS t0_r5, "product_property_groups"."created_at" AS t0_r6, "product_property_groups"."updated_at" AS t0_r7, "product_properties"."id" AS t1_r0, "product_properties"."name" AS t1_r1, "product_properties"."position" AS t1_r2, "product_properties"."state" AS t1_r3, "product_properties"."aliaz" AS t1_r4, "product_properties"."product_property_group_id" AS t1_r5, "product_properties"."created_at" AS t1_r6, "product_properties"."updated_at" AS t1_r7 FROM "product_property_groups" LEFT OUTER JOIN "product_properties" ON "product_properties"."product_property_group_id" = "product_property_groups"."id" WHERE (product_properties.name = 'n1')
 => #<ActiveRecord::Relation [#<ProductPropertyGroup id: 1, name: "g1", position: 1, state: "published", aliaz: "g1", service_id: 4, created_at: "2016-03-21 00:00:00", updated_at: "2016-03-21 00:00:00">]>  
 
 ProductPropertyGroup.preload(:product_properties).where("product_properties.name = ?", "n1").references(:product_properties)
  ProductPropertyGroup Load (2.6ms)  SELECT "product_property_groups".* FROM "product_property_groups" WHERE (product_properties.name = 'n1')
ActiveRecord::StatementInvalid: PG::UndefinedTable: ERROR:  missing FROM-clause entry for table "product_properties"
LINE 1: ...y_groups".* FROM "product_property_groups" WHERE (product_pr...  
   -- preload是2个sql 不能用关联表的字段做查询条件！  
```

- ActiveModel::SecurePassword  



###recipes  

- rspec中导入种子数据。  
 在spec_helper.rb中加入  
`load Rails.root + "db/seeds.rb" `  

> http://stackoverflow.com/questions/8386604/auto-load-the-seed-data-from-db-seeds-rb-with-rake  



- Redirect to previous page  

> http://stackoverflow.com/questions/2139996/how-to-redirect-to-previous-page-in-ruby-on-rails  
> http://stackoverflow.com/questions/771656/correctly-doing-redirect-to-back-in-ruby-on-rails-when-referrer-is-not-availabl  

```ruby
def store_location
  session[:return_to] = request.request_uri
end

def redirect_back_or_default(default)
  redirect_to(session[:return_to] || default)
  session[:return_to] = nil
end
```

###controller concern  

```ruby
class AdminController < ApplicationController
  before_filter :check_admin_user

  private

  def check_admin_user
    unless current_user.admin
      flash[:alert] = "You can't be here!"
      redirect_to root_path
    end
  end
end
```


# Rails Best practices

### In Model 

-1. Move code from Controller to Model  
Action code 超过15行的请注意。

-2. Move Finder to named scope   

-3. Use Model Association  

-4. Use scope access 
```ruby
current_user.posts.find(1) #current_user的 posts找不到 id＝1 的自然抛出异常
```

-5. Use Model callback  

-6. Replace complex Creation with Factory Method  
```ruby
 def self.new_by_user(params, user)
```

-7. Move Model logic into the Model  

-8. Learn to use model.collection_model_ids to increase or descrease the collection
```ruby
@user.role_ids = params[:user][:role_ids]
```

-9. Nested Model Forms 
```ruby
class Product
 accepts_nested_attributes_for: details
end
```  
then, we can use:
```ruby
 @product.update(details_attributes: [{id: 1, ...}, {id: 2, ...}, ...]) 
 
 #one-to-one: 
 @product.update(detail_attributes: {id: 1, ...}) 
```

-10. Keep Finders on Their Own Model

-11. Love named_scope  

-12. Use delegate to associtations' methods, especially in Front-end
```ruby
class Invoice < ActiveRecord::Base
  belongs_to :user
  delegate :name, :address, :cellphone, to: :user, prefix: true
end

<%= @invoice.user_name %>
<%= @invoice.user_address %>
<%= @invoice.user_cellphone %> 

# which are better than below: 
<%= @invoice.user.name %>

```

-13. DRY: Metaprogramming  
```ruby
class Post < ActiveRecord::Base
  STATUSES = ['draft', 'published', 'spam']
  validate_inclusion_of :status, :in => STATUSES
  class << self
    STATUSES.each do |status_name|
      define_method "all_#{status}" do
        find(:all, :conditions => { :status => status_name }
      end 
    end
  end
  STATUSES.each do |status_name|
    define_method "#{status_name}?" do
      self.status == status_name
    end
  end 
end
```

-14. Breaking up Model 帮Model减重  
 
Extract into Module: '/lib/xxx.rb'

-15. Use Observer 
```ruby
class Project < ActiveRecord::Base
  # nothing here
end
# app/observers/project_notification_observer.rb
class ProjectNotificationObserver < ActiveRecord::Observer
  observe Project
  def after_create(project)
    project.members.each do |member|
      ProjectMailer.deliver_notice(project, member)
    end 
  end
end
```

### In Migration  

-1. Isolating Seed Data  

-2. Always add DB index  

### In Controller

-1. Use before_filter  
```ruby
 before_filter :find_post, only: [:show, :edit, :update, :destroy]
```

### In View  

-1. Never logic code in Views  
 
Move code into controller / model / helper  

-2. Organize Helper files 

-3. Learn Rails Helpers

 - Learn content_for and yield 
 - Learn how to pass block parameter in helper
 - Read Rails helpers source code 
 /actionpack-x.y.z/action_view/helpers/*  

 
### In routes, use Restful style / conventions

-1. Needless deep nesting  


### Code refactor!  
