#RabbitMQ 
MQ（Message Queue）即消息队列，一般用于应用系统解耦、消息异步分发，能够提高系统吞吐量。   
> http://www.rabbitmq.com/install-homebrew.html  
  http://www.rabbitmq.com/getstarted.html  --Get started   
  http://blog.chinaunix.net/topic/surpershi/  --应用场景    
  http://my.oschina.net/ydsakyclguozi/blog/417087?p=1  --与redis的对比     
  https://github.com/ruby-amqp/bunny   --Ruby client for RabbitMQ
  http://rubybunny.info/articles/getting_started.html  --ruby 中使用RabbitMQ   

* Start server :    
`rabbitmq-server`   -detatched选项参数表示以守护进程方式启动服务。   
May use it:  
```
# RabbitMQ Config
export PATH=$PATH:/usr/local/sbin  
```

* 查看所有插件信息:   
`rabbitmq-plugins list`  

* 管理工具:  
RabbitMQ提供了`rabbitmqctl`和`rabbitmqadmin`命令行管理工具，它们都是RabbitMQ的插件.   
`rabbitmqctl -q command  /   rabbitmqctl -n node `    

**Web UI管理消息服务器**  
打开浏览器，输入 http://[server-name]:15672/ 如 http://localhost:15672/     ，会要求输入用户名和密码，用默认的guest/guest即可（guest/guest用户只能从localhost地址登录，如果要配置远程登录，必须另创建用户）   

添加远程管理账户:   
如果要从远程登录怎么做呢？处于安全考虑，guest这个默认的用户只能通过http://localhost:15672来登录，其他的IP无法直接用这个guest帐号。这里我们可以通过配置文件来实现从远程登录管理界面，只要编辑/etc/rabbitmq/rabbitmq.config文件（没有就新增），添加以下配置就可以了。  
```
[  
{rabbit, [{tcp_listeners, [5672]}, {loopback_users, ["asdf"]}]}  
].
```
现在添加了一个新授权用户asdf,可以远程使用这个用户名。记得要先用命令添加这个命令才行：   
```
#Linux
$  cd /usr/lib/rabbitmq/bin/
#用户名与密码
$ sudo rabbitmqctl add_user asdf 123456
#用户设置为administrator才能远程访问
$ sudo rabbitmqctl set_user_tags asdf administrator         
$ sudo rabbitmqctl set_permissions -p / asdf ".*" ".*" ".*"   
```   
其实也可以通过管理平台页面直接添加用户和密码等信息。如果还不能远程访问或远程登录检查是不是5672, 15672端口没有开放！    


