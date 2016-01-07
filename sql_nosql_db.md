#Postgresql  
* Installing On OSX :  `brew install postgresql -v`  
* Initialize Postgresql server : `initdb /usr/local/var/postgres -E utf8`    --指定 "/usr/local/var/postgres" 为 PostgreSQL 的配置数据存放目录，并且设置数据库数据编码是 utf8，更多配置信息可以 "initdb --help" 查看   

* Set startup When Computer starts :
```
  ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```
* StartUp      :   
   `pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start`    
* Close        :    
   `pg_ctl -D /usr/local/var/postgres stop -s -m fast`   
* Create db    :   
   `createdb dbname -O username -E UTF8 -e`  
* Access to    :   
   `psql -U username -d dbname -h 127.0.0.1`  
* List         :    
   `psql -l`   
* Access one   :   
   `\c dbname`   
* Show tables  :    
   `\d`   


#MongoDB   
Description:  MongoDB是一个面向文档的数据库，采用乐观并发控制(乐观锁)    
文件存储格式为BSON（一种JSON的扩展）  
  > docs  :  https://docs.mongodb.org    
  > basic command :    
  http://www.cnblogs.com/TankMa/archive/2011/06/08/2074947.html  
  http://www.cnblogs.com/zengen/archive/2011/04/23/2025722.html    
  http://snowolf.iteye.com/blog/1974747   
  
mongoDB 使用场景  
> http://www.oschina.net/translate/why-you-should-never-use-mongodb?print   
> http://blog.itpub.net/21601207/viewspace-745088/   --mongodb 使用场景和不使用场景   

mongoDB 不支持事务的答疑   
> http://blog.csdn.net/leon_7mx/article/details/43767823    --Stack Overflow上一些关于MongoDB事务的问答   
> http://www.csdn.net/article/2014-08-07/2821104-Implement-Robust-and-Scalable-Transactions-with-MongoDB   
  
* Installing on OSX:    
   `brew install mongodb`  
* 启动MongoDB:  
   `mongod --config /usr/local/etc/mongod.conf`  
* Access to MongoDB with Command:  
   `mongo`    
`MongoDb的可视化管理工具:  Robomongo   `  

###Mongo command:   
* `db.help()`          :  Show help for database methods  
* `show dbs`           :  Show disk usage  
* `show users`         :  Print a list of users for current database  
* `show roles`         :  Print a list of all roles, both user-defined and built-in, for the current database   
* `show collections`   :  Print a list of all collections for current database     
* `show databases`     :  Print a list of all available databases      

###Create users  
```
  db.createUser(
   {
     user: "accountUser",
     pwd: "password",
     roles: [ "readWrite", "dbAdmin" ]
   }
)
```
* `use database_name`  创建database_name数据库 (先创建数据库，再创建用户)       
* 创建聚合   
  ```
    db.createCollection(“collName”, {size: 20, capped: 5, max: 100})           
  ```
* 获得聚合    
  ```
    show collections  查看所有聚合  
    db.getCollection("account")  
  ```
* 查看数据库状态  
`db.stats()`  
`db.blog.stats()`  查看聚合状态参数  

* CRUD  
  Insert : 
```
> post = {"title":"My Blog Post",  
... "content":"Here's my blog post.",  
... "date":new Date()}  
{  
        "title" : "My Blog Post",  
        "content" : "Here's my blog post.",  
        "date" : ISODate("2013-01-23T05:29:08.151Z")  
}  
> db.blog.insert(post)  
```

  Find :  
```
> db.blog.find()   --find all
{ "_id" : ObjectId("50ff75376201fe04d53e42ed"), "title" : "My Blog Post", "content" : "Here's my blog post.", "date" : ISODate("2013-01-23T05:29:08.151Z") }  

> db.blog.find({"title":"My Blog Post"})  --find all of title = ...
{ "_id" : ObjectId("50ff75376201fe04d53e42ed"), "title" : "My Blog Post", "content" : "Here's my blog post.", "date" : ISODate("2013-01-23T05:29:08.151Z") }   

> db.blog.findOne({"title":"My Blog Post", "content" : "Here's my blog post."})    --find one
{  
        "_id" : ObjectId("5107257f2f0dc8fbf16e8f28"),  
        "title" : "My Blog Post",  
        "content" : "Here's my blog post.",  
        "date" : ISODate("2013-01-29T01:27:21.858Z")  
}  
```

  Update:  
```
> post.comments=[]  
[ ]  
> db.blog.update({"title":"My Blog Post"},post)  
```

  Remove:
```
> db.blog.remove({"title" : "My Blog Post"})  --remove all of title ...  
> db.blog.find({"title" : "My Blog Post"})  
>   
```

*  基础数据类型  
```
  null       : 空值，或不存在的字段  
  {"x":null}   
  
  undefined  : 未定义 
  {"x":undefined}  
  
  boolean    : 布尔，'true' | 'false'  
  {"x":true}   
  
  double     : 浮点数，不管是32位，还是64位的整数，最后都被统一为64位浮点数   
  {"x":3.14}  
  
  String     : 字符串，其值为UTF-8编码  
  {"x":"test"}   
  
  id        : 唯一标识  
  {"x":new ObjectId()}    
  
  Date      : 日期  
  {"x":new Date()}   
  
  Arrary    : 数组
  {"x":["a", "b", "c"]}    
  
  Document  : 内嵌文档  
  {"x":{"name":"zlex"}}   
  
  Code      : 代码，即JavaScript代码
  {"x": function(){/* ... */}}   
  
  Regular Expression  : 正则表达式
  {"x": /foobar/i}    
```  

**Modifier 修改器**  
本以为Mongodb的CRUD就是些常规操作，其实不然，针对字段、数组的操作还有很多特定指令——修改器  
```
  $inc、$set、$unset、$push、$pull、$ne、$addToSet、$each等，主要用于更新操作   
  $or、 $not、 $lt、$gt、$lte、$gte、 $in、$nin等， 主要用于查询范围限定  
```


#Mysql   
* Install on OSX    
`brew install mysql`     
`unset TMPDIR` to avoid `ERROR 2002 (HY000): Can not connect to local MySQL server through socket '/tmp/mysql.sock' (2)`  

* 起服务  
`mysql.server start`    

* 登陆  
`mysql -uroot -p`    
`mysql -D 所选择的数据库名 -h 主机名 -u 用户名 -p`   
执行 use samp_db 来选择刚刚创建的数据库, 选择成功后会提示: Database changed     

* Mysql中数据库类型   
```
数字类型
整数: tinyint、smallint、mediumint、int、bigint
浮点数: float、double、real、decimal

日期和时间: date、time、datetime、timestamp、year

字符串类型
字符串: char、varchar
文本: tinytext、text、mediumtext、longtext

二进制(可用来存储图片、音乐等): tinyblob、blob、mediumblob、longblob
```

* create database samp_db character set gbk;   
为了便于在命令提示符下显示中文, 在创建时通过 character set gbk 将数据库字符编码指定为 gbk。    

* 创建表  
Mysql 中的约束条件：   
```
create table students
	（
		id int unsigned not null auto_increment primary key,
		name char(8) not null,
		sex char(4) not null,
		age tinyint unsigned not null,
		tel char(13) null default "-"
	);
```

*Mysql 与postgresql比较  
```
著作权归作者所有。
商业转载请联系作者获得授权，非商业转载请注明出处。
作者：Zete
链接：https://www.zhihu.com/question/20010554/answer/62628256
来源：知乎

Pg 没有 MySQL 的各种坑MySQL 的各种 text 字段有不同的限制, 要手动区分 small text, middle text, large text...  
Pg 没有这个限制, text 能支持各种大小.按照 SQL 标准, 做 null 判断不能用 = null, 只能用 is nullthe result of any arithmetic comparison with NULL is also NULL
但 pg 可以设置 transform_null_equals 把 = null 翻译成 is null 避免踩坑

不少人应该遇到过 MySQL 里需要 utf8mb4 才能显示 emoji 的坑, Pg 就没这个坑.MySQL 的事务隔离级别 repeatable read 并不能阻止常见的并发更新, 得加锁才可以, 但悲观锁会影响性能, 手动实现乐观锁又复杂. 而 Pg 的列里有隐藏的乐观锁 version 字段, 默认的 repeatable read 级别就能保证并发更新的正确性, 并且又有乐观锁的性能. 

附带一个各数据库对隔离级别的行为差异比较调查: http://www.cs.umb.edu/~poneil/iso.pdfMySQL 不支持多个表从同一个序列中取 id, 而 Pg 可以.MySQL 不支持 OVER 子句, 而 Pg 支持. OVER 子句能简单的解决 "每组取 top 5" 的这类问题.

几乎任何数据库的子查询 (subquery) 性能都比 MySQL好.

更多的坑:http://blog.ionelmc.ro/2014/12/28/terrible-choices-mysql/不少人踩完坑了, 以为换个数据库还得踩一次, 所以很抗拒, 事实上不是!!!Pg 不仅仅是 SQL 数据库它可以存储 array 和 json, 可以在 array 和 json 上建索引, 甚至还能用表达式索引.

为了实现文档数据库的功能, 设计了 jsonb 的存储结构. 有人会说为什么不用 Mongodb 的 BSON 呢? Pg 的开发团队曾经考虑过, 但是他们看到 BSON 把 ["a", "b", "c"] 存成 {0: "a", 1: "b", 2: "c"} 的时候就决定要重新做一个 jsonb 了... 

现在 jsonb 的性能已经优于 BSON.现在往前端偏移的开发环境里, 用 Pg + PostgREST 直接生成后端 API 是非常快速高效的办法:begriffs/postgrest · GitHubpostgREST 的性能非常强悍, 一个原因就是 Pg 可以直接组织返回 json 的结果.它支持服务器端脚本: TCL, Python, R, Perl, Ruby, MRuby ... 自带 map-reduce 了.它有地理信息处理扩展 (GIS 扩展不仅限于真实世界, 游戏里的地形什么的也可以), 可以用 Pg 搭寻路服务器和地图服务器:PostGIS — Spatial and Geographic Objects for PostgreSQL它自带全文搜索功能 (不用费劲再装一个 elasticsearch 咯):Full text search in milliseconds with

PostgreSQL 不过一些语言相关的支持还不太完善, 有个 bamboo 插件用调教过的 mecab 做中文分词, 如果要求比较高, 还是自己分了词再存到 tsvector 比较好.它支持 trigram 索引.trigram 索引可以帮助改进全文搜索的结果: 
PostgreSQL: Documentation: 9.3: pg_trgmtrigram 还可以实现高效的正则搜索 (原理参考 https://swtch.com/~rsc/regexp/regexp4.html )

MySQL 处理树状回复的设计会很复杂, 而且需要写很多代码, 而 Pg 可以高效处理树结构:Scaling Threaded Comments on Django at Disqushttp://www.slideshare.net/quipo/trees-in-the-database-advanced-data-structures它可以高效处理图结构, 轻松实现 "朋友的朋友的朋友" 这种功能:http://www.slideshare.net/quipo/rdbms-in-the-social-networks-age

心动不如行动Converting MySQL to PostgreSQL
```

#Oracle   



#数据库知识概念     

**乐观锁 和 悲观锁**   
> http://blog.codingnow.com/2014/12/skynet_spinlock.html   

```
悲观锁(Pessimistic Lock), 顾名思义，就是很悲观，每次去拿数据的时候都认为别人会修改，所以每次在拿数据的时候都会上锁，这样别人想拿这个数据就会block直到它拿到锁。传统的关系型数据库里边就用到了很多这种锁机制，比如行锁，表锁等，读锁，写锁等，都是在做操作之前先上锁。



乐观锁(Optimistic Lock), 顾名思义，就是很乐观，每次去拿数据的时候都认为别人不会修改，所以不会上锁，但是在更新的时候会判断一下在此期间别人有没有去更新这个数据，可以使用版本号等机制。乐观锁适用于多读的应用类型，这样可以提高吞吐量，像数据库如果提供类似于write_condition机制的其实都是提供的乐观锁。



两种锁各有优缺点，不可认为一种好于另一种，像乐观锁适用于写比较少的情况下，即冲突真的很少发生的时候，这样可以省去了锁的开销，加大了系统的整个吞吐量。但如果经常产生冲突，上层应用会不断的进行retry，这样反倒是降低了性能，所以这种情况下用悲观锁就比较合适。
```  


  


   
