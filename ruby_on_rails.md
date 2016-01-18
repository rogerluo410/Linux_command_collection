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

#API Description Generator  
> http://apidocjs.com   
> https://github.com/apidoc/apidoc   

#Rspec   
> http://my.oschina.net/huangwenwei/blog/418999   --RSpec入门指南   
> http://www.jianshu.com/p/1db9ee327357  --RSpec入门指南    

```  
它在BDD流程的开发中被用来写高可读性的测试，引导并验证你开发的应用程序。
#常用模式：  
before(:all) { #全局变量赋值，只执行一遍，每个测试方法都可以用，变量最好设置为实例变量 @param  } 
before(:each) { #全局变量赋值，每个测试方法运行前都会执行一遍，变量最好设置为实例变量 @param  } 
describe '描述这个方法的测试目的' do
 let(:arg1) { #做测试使用变量的赋值 }
 let(:arg2) { #做测试使用变量的赋值 }
 context '描述测试时的上下文环境，它能让测试更清晰，有条理' do
   #别用should，用expect 
   #别用fixtures， 用Factory
   
   expect(actual).to be(expected)    # passes if actual.equal?(expected)
   expect(actual).to equal(expected) # passes if actual.equal?(expected)
   #=> https://github.com/rspec/rspec-expectations  how to use expect  
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

Factory_girl: 
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

##以上是controller的测试模式， model的模式可以使用subject方法。
```

#capybara   
Acceptance test framework for web applications   
> https://github.com/jnicklas/capybara    

#Factory_girl  
A library for setting up Ruby objects as test data.  
> https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md   

#Guard     
使用 Guard 你可以自动化的运行那些和你正在修改的测试，Model，Controller 或者文件有关的测试。    
> https://github.com/guard/guard     

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

#Rails with mongoDB  
```
As far as I am concerned you will have to create a new Rails project excluding active record:

rails new my_app --skip-active-record
then you can follow the configuration steps from Mongoid:

http://mongoid.org/en/mongoid/docs/installation.html
```

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
它可以降低测试时web分布式组件之间的偶尔度，加速测试速度。  
> https://github.com/vcr/vcr  
> http://www.thegreatcodeadventure.com/stubbing-with-vcr/   --use webmock + vcr  
> http://qiita.com/xiangzhuyuan/items/9f3301cd30e09369e7d1  --创建假的服务api路由一定要写对， 否则模拟失败。  
> https://ruby-china.org/topics/26588  --使用 Webmock 和 VCR 搭建测试，对调用第三方 API 库的支持(本地fake第三方api, 不需要使用vcr的replay功能)   

#Cache
##record-cache   
Cache Active Model Records in Rails 3   
> https://github.com/orslumen/record-cache   

##simple_cacheable   
Simple Cacheable is a simple cache implementation based on activerecord  
> https://github.com/flyerhzm/simple_cacheable
----------------------------------

#Rails 
> http://guides.rubyonrails.org/active_record_validations.html  --active model validations   
> http://guides.rubyonrails.org/active_record_querying.html     --active record querying  
> http://guides.rubyonrails.org/active_record_callbacks.html    --active record callbacks   
> http://edgeguides.rubyonrails.org/active_record_migrations.html  --active record migrations  
> http://guides.rubyonrails.org/association_basics.html  --active record association  
> https://www.rubyplus.com/articles  --rails cast  

###String 
> http://guides.ruby-china.org/active_support_core_extensions.html   

```
as_json
classify
constantize
humanize
tableize
```

###In Model class, We can add: 
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


**rails中缓存的使用**  
> http://hawkins.io/2011/05/advanced_caching_in_rails/     
> http://hawkins.io/2012/07/advanced_caching_revised/   
