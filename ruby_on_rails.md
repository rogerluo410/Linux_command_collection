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

```ruby    
它在BDD流程的开发中被用来写高可读性的测试，引导并验证你开发的应用程序。
#常用模式：  
before(:all) { #全局变量赋值，只执行一遍，每个测试方法都可以用，变量最好设置为实例变量 @param  } 
before(:each) { #全局变量赋值，每个测试方法运行前都会执行一遍，变量最好设置为实例变量 @param  } 
describe '描述这个方法的测试目的' do
 let(:arg1) { #做测试使用变量的赋值 }
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
如果你有好几个测试都是用了同一个 subject，使用 subject{} 来避免重复。  
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

 6。使用Fuubar   
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

###String In Active Support:   
> http://guides.ruby-china.org/active_support_core_extensions.html   

```
as_json
classify
constantize
humanize
tableize
```

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
   * 

###In view: 
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

**关联查询以及预加载**  
> https://ruby-china.org/topics/22192   --ActiveRecord 的三种数据预加载形式 - includes, preload, eager_load  


