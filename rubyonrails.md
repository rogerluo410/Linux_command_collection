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
            * 


#Ruby 语法   
> http://www.runoob.com/ruby/ruby-hash.html  

#Rspec   
> http://my.oschina.net/huangwenwei/blog/418999   --RSpec入门指南   
> http://www.jianshu.com/p/1db9ee327357  --RSpec入门指南    

#Factory_girl  
> https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md   

#Guard     
使用 Guard 你可以自动化的运行那些和你正在修改的测试，Model，Controller 或者文件有关的测试。    
> https://github.com/guard/guard     

#EventMachine-scalable-non-blocking IO
> http://www.scribd.com/doc/28253878/EventMachine-scalable-non-blocking-i-o-in-ruby   

#Mina  
> http://yafeilee.me/blogs/5550f3006c693403675a0000   

#state_machine   
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

#mime-types    
The mime-types library provides a library and registry for information about MIME content type definitions.    
> https://github.com/mime-types/ruby-mime-types

#Rails 
> http://guides.rubyonrails.org/active_record_validations.html  --active model validations   
> http://guides.rubyonrails.org/active_record_querying.html     --active record querying  
> http://guides.rubyonrails.org/active_record_callbacks.html    --active record callbacks   
> http://edgeguides.rubyonrails.org/active_record_migrations.html  --active record migrations  
> http://guides.rubyonrails.org/association_basics.html  --active record association  

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
