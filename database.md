# Postgresql  

> http://www.postgres.cn/docs/9.3/index.html  --中文文档  

* Installing On OSX :  `brew install postgresql -v`  
* Initialize Postgresql server : `initdb /usr/local/var/postgres -E utf8`    --指定 "/usr/local/var/postgres" 为 PostgreSQL 的配置数据存放目录，并且设置数据库数据编码是 utf8，更多配置信息可以 "initdb --help" 查看   
* 会默认创建一个postgres数据库，用户名是你的计算机用户名, 密码是主机用户名密码。   
  ( 使用brew services 启动服务查看错误： tail /usr/local/Homebrew/var/log/postgres.log  )

* Set startup When Computer starts :
```
  ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```
* StartUp      :   
   `pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start`    
* Close        :    
   `pg_ctl -D /usr/local/var/postgres stop -s -m fast`   
* Create user  :  
   `createuser --pwprompt postgres`  -- ithout a password just take the --pwprompt off the command.  
* ALTER ROLE   :
   `psql postgres`  && `ALTER ROLE postgres CREATEDB;`   
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
* 导入/导出:  
  `
    pg_dump mydb > db.sql   # mydb数据库导出SQL-script file  
    psql -d newdb -f db.sql  # SQL-script file 导入到数据库 newdb  
    
    https://www.postgresql.org/docs/9.1/app-pgdump.html
  `

- 无法连接本地postgresql：  
```
2016-08-09 10:28:56 +0800: Rack app error: #<PG::ConnectionBad: could not connect to server: No such file or directory
	Is the server running locally and accepting
	connections on Unix domain socket "/tmp/.s.PGSQL.5432"?
```	
Solution: `rm /usr/local/var/postgres/postmaster.pid` 

> http://stackoverflow.com/questions/13410686/postgres-could-not-connect-to-server/35805546#35805546   


* 关于远程登录ubuntu下的postgresql服务的注意事项： 
> http://www.postgresql.org/docs/current/static/auth-pg-hba-conf.html  
> http://www.postgresql.org/docs/current/static/runtime-config-connection.html#GUC-LISTEN-ADDRESSES   
```
安装PostgreSQL数据库之后，默认是只接受本地访问连接。如果想在其他主机上访问PostgreSQL数据库服务器，就需要进行相应的配置。

配置远 程连接PostgreSQL数据库的步骤很简单，只需要修改data目录下的pg_hba.conf和postgresql.conf。

pg_hba.conf：配置对数据库的访问权限，

postgresql.conf：配置PostgreSQL数据库服务器的相应的参数。

下面 介绍配置的步骤：

1.修改pg_hba.conf文件，配置用户的访问权限（#开头的行是注释内容）：

# TYPE DATABASE USER CIDR-ADDRESS METHOD
# "local" is for Unix domain socket connections only
local all all trust
# IPv4 local connections:
host all all 127.0.0.1/32 trust
host all all 192.168.1.0/24 md5
# IPv6 local connections:
host all all ::1/128 trust
其中，第7条是新添加的内容，表示允许网段192.168.1.0上的所有主机使用所有合法的数据库用户名访问数据库，并提供加密的密码验证。

其中，数字24是子网掩码，表示允许192.168.1.0--192.168.1.255的计算机访问！

 

2.修改postgresql.conf文件，将数据库服务器的监听模式修改为监听所有主机发出的连接请求。

定位到#listen_addresses=’localhost’。PostgreSQL安装完成后，默认是只接受来在本机localhost的连接请 求。

将行开头都#去掉，将行内容修改为listen_addresses=’*'来允许数据库服务器监听来自任何主机的连接请求

3.重启postgresql服务  
sudo service postgresql restart  
sudo /etc/init.d/postgresql restart   
```

### 使用手册

**LIMIT 和 OFFSET**  
```sql
 在使用LIMIT 和 OFFSET时，结果集必须有主键 或 排序，并且排序需要强排序（唯一性字段上有排序）以便返回一个可预料的顺序，否则返回结果得不到预期值。
 >  http://www.php100.com/manual/PostgreSQL8/queries-limit.html
```

**如何在查询选项中制作一个伪列**  
```sql
SELECT
    COUNT (*) AS cnt,
    CASE
      WHEN product_property_id IN (
	SELECT
	  product_property_values.product_property_id
	FROM
	  product_property_values
	INNER JOIN products ON product_property_values.product_id = products.id
	AND (
	  organization_id = #{params[:team_id]}
	  AND STATE = 'published'
	)
	) 
      THEN
	1
      ELSE
	0
      END AS INCLUDE_FLAG,
      product_property_id
FROM
   product_property_values
GROUP BY
   product_property_id
ORDER BY
   INCLUDE_FLAG, cnt DESC
``` 

**select top three in each group 分组后取每组的前TOP个（使用ROW_NUMBER()函数**  
> http://stackoverflow.com/questions/27415706/postgresql-select-top-three-in-each-group  
> http://sqlfiddle.com/#!15/e1f71/39   --实例  

```
SELECT product_properties.*, extend_row_ids.rowid FROM "product_properties" LEFT OUTER JOIN (
            SELECT
              COUNT (*) AS cnt,
              CASE
              WHEN product_property_id IN (
                SELECT
                  product_property_values.product_property_id
                FROM
                  product_property_values
                INNER JOIN products ON product_property_values.product_id = products.id
                AND (
                  organization_id = 63
                  AND STATE = 'published'
                )
              ) 
              THEN
                1
              ELSE
                0
              END AS INCLUDE_FLAG,
              product_property_id
            FROM
              product_property_values
            GROUP BY
              product_property_id
            ORDER BY
              INCLUDE_FLAG, cnt DESC
            ) team_product_properties ON team_product_properties.product_property_id = product_properties.id 
            INNER JOIN (
            SELECT
              id, ROW_NUMBER() OVER (
                PARTITION BY product_property_group_id
              ) AS ROWID
            FROM
              product_properties
            ) extend_row_ids ON product_properties.ID = extend_row_ids.ID WHERE "product_properties"."state" = $1 AND "product_properties"."product_property_group_id" IN (1, 2) AND (ROWID <= '3') AND "product_properties"."product_property_group_id" = $2  
            
            
SELECT company, val FROM 
(
    SELECT *, ROW_NUMBER() OVER (PARTITION BY 
             company order by val DESC) AS Row_ID FROM com
) AS A
WHERE Row_ID < 4 ORDER BY company  --注意要使用子集的方式才能访问伪列 row_id  

```

**exists 的用法**  
```sql
SELECT
	*
FROM
	strangers
WHERE
	"owner_id" = 198
AND NOT EXISTS (
	SELECT
		'X'
	FROM
		(
			SELECT
				*
			FROM
				clients cc,
				strangers bb
			WHERE
				cc.stranger_id = bb.id
			AND cc.cluster_id = 1081
		) aa
	WHERE
		aa.user_id = strangers. user_id
)

In ORM: 
strangers.where("not exists (select 'X' from (select * from clients cs, strangers st where cs.stranger_id = st.id AND cs.cluster_id = ?) cc where cc.user_id = strangers.user_id)", params[:cluster_id])

在子查询中匹配范围时，用exists, not exists 比 in, not in 好的原因是：  

在许多基于基础表的查询中,为了满足一个条件,往往需要对另一个表进行联接.在这种情况下, 使用EXISTS(或NOT EXISTS)通常将提高查询的效率. 在子查询中,NOT IN子句将执行一个内部的排序和合并. 无论在哪种情况下,NOT IN都是最低效的 (因为它对子查询中的表执行了一个全表遍历). 为了避免使用NOT IN ,我们可以把它改写成外连接(Outer Joins)或NOT EXISTS（子查询中，需要和主表关联！）. 

```  

# MongoDB   
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

### Mongo command:   
* `db.help()`          :  Show help for database methods  
* `show dbs`           :  Show disk usage  
* `show users`         :  Print a list of users for current database  
* `show roles`         :  Print a list of all roles, both user-defined and built-in, for the current database   
* `show collections`   :  Print a list of all collections for current database     
* `show databases`     :  Print a list of all available databases      

### Create users  
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

  Mongodb内置的全文检索:  
```
> db.test.drop()
> db.test.insert({ "t" : "I'm on time, not late or delayed" })
> db.test.insert({ "t" : "I'm either late or delayed" })
> db.test.insert({ "t" : "Time flies like a banana" })
> db.test.ensureIndex({ "t" : "text" })

> db.test.find({ "$text" : { "$search" : "time late delay" } }, { "_id" : 0 })
{ "t" : "I'm on time, not late or delayed" }
{ "t" : "Time flies like a banana" }
{ "t" : "I'm either late or delayed" }

> db.test.find({ "$text" : { "$search" : "late delay" } }, { "_id" : 0 })
{ "t" : "I'm on time, not late or delayed" }
{ "t" : "I'm either late or delayed" }

> db.test.find({ "$text" : { "$search" : "late delay \"on time\"" } }, { "_id" : 0 })
{ "t" : "I'm on time, not late or delayed" }
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

**_id和ObjectId**
```
MongoDB 中存储的文档必须有一个"_id" 键。这个键的值可以是任何类型的，默认是个ObjectId 对象。在一个集合里面，每个文档都有唯一的"_id" 值，来确保集合里面每个文档都能被唯一标识。如果有两个集合的话，两个集合可以都有一个值为123 的"_id" 键，但是每个集合里面只能有一个"_id" 是123 的文档。

1. ObjectId
ObjectId 是"_id" 的默认类型。它设计成轻量型的，不同的机器都能用全局唯一的同种方法方便地生成它。这是MongoDB 采用ObjectId，而不是其他比较常规的做法（比如自动增加的主键）的主要原因，因为在多个服务器上同步自动增加主键值既费力还费时。MongoDB 从一开始就设计用来作为分布式数据库，处理多个节点是一个核心要求。后面会看到ObjectId 类型在分片环境中要容易生成得多。

ObjectId 使用12 字节的存储空间，每个字节两位十六进制数字，是一个24 位的字符串。由于看起来很长，不少人会觉得难以处理。但关键是要知道这个长长的ObjectId 是实际存储数据的两倍长。

如果快速连续创建多个ObjectId，会发现每次只有最后几位数字有变化。另外，中间的几位数字也会变化（要是在创建的过程中停顿几秒钟）。这是ObjectId 的创建方式导致的。12 字节按照如下方式生成：

  0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 
       时间戳   |  机器     |  PID  |  计数器

前4 个字节是从标准纪元开始的时间戳，单位为秒。这会带来一些有用的属性。时间戳，与随后的. 5 个字节组合起来，提供了秒级别的唯一性。
由于时间戳在前，这意味着ObjectId 大致会按照插入的顺序排列。这对于某些方面很有用，如将其作为索引提高效率，但是这个是没有保证的，仅仅是“大致”。


这4 个字节也隐含了文档创建的时间。绝大多数驱动都会公开一个方法从ObjectId 获取这个信息。
因为使用的是当前时间，很多用户担心要对服务器进行时间同步。其实没有这个必要，因为时间戳的实际值并不重要，只要其总是不停增加就好了（每秒一次）。


接下来的3 字节是所在主机的唯一标识符。通常是机器主机名的散列值。这样就可以确保不同主机生成不同的ObjectId，不产生冲突。
为了确保在同一台机器上并发的多个进程产生的ObjectId 是唯一的，接下来的两字节来自产生ObjectId 的进程标识符（PID）。


前9 字节保证了同一秒钟不同机器不同进程产生的ObjectId 是唯一的。后3 字节就是一个自动增加的计数器，确保相同进程同一秒产生的ObjectId 也是不一样的。同一秒钟最多允许每个进程拥有2563（16 777 216）个不同的ObjectId。


2. 自动生成_id
前面讲到，如果插入文档的时候没有"_id" 键，系统会自动帮你创建一个。可以由MongoDB 服务器来做这件事情，但通常会在客户端由驱动程序完成。理由如下。

虽然ObjectId 设计成轻量型的，易于生成，但是毕竟生成的时候还是产生开销。在客户端生成体现了MongoDB 的设计理念：能从服务器端转移到驱动程序来做的事，就尽量转移。这种理念背后的原因是，即便是像MongoDB 这样的可扩展数据库，扩展应用层也要比扩展数据库层容易得多。将事务交由客户端来处理，就减轻了数据库扩展的负担。

在客户端生成ObjectId，驱动程序能够提供更加丰富的API。例如，驱动程序可以有自己的insert 方法，可以返回生成的ObjectId，也可以直接将其插入文档。如果驱动程序允许服务器生成ObjectId，那么将需要单独的查询，以确定插入的文档中的"_id" 值。
```


# Mysql   
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

* Mysql 与postgresql比较  
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

# Oracle   
* sql语句优化和索引的使用  
```
1.最常见的索引扫描类型为 唯一扫描 和 范围扫描。主键索引或 定义了unique的列的索引会定义为唯一索引。一般的索引则会定义为范围性索引。

2.索引的用途：当从表中访问数据时，Oracle提供了两个选择：从表中读取每一行(即全表扫描)，或者通过ROWID一次读取一行。当访问大型表的少量行时，可能想使用索引。

3.索引通常能提高查询语句的效率，但是对insert，update，delete等dml语句，则会影响其执行效率。

4.组合索引：create index emp_id1 on emp(empno, ename, deptno);
这就是一个组合索引。虽然，9i引入了跳跃式扫描索引访问方法，增加了优化器在使用组合索引时的选择。但是，也要谨慎地选择索引列的顺序，一般来说，第一列是最有可能在where子句中使用的列，也是索引中最句选择性的列。
select job, empno  from emp  where ename = 'RICH';
因为Ename不是索引的第一列，优化器可能会选择不使用该索引。优化器可能选择执行索引快速扫描访问、索引快速全局扫描或全表扫描。

最好总是使用索引的第一个列： 
如果索引是建立在多个列上, 只有在它的第一个列(leading column)被where子句引用时,优化器才会选择使用该索引. 这也是一条简单而重要的规则，当仅引用索引的第二个列时,优化器使用了全表扫描而忽略了索引 。

5.限制索引的使用
Sql语句的一些缺陷会是索引无法使用。
(1)使用不等于运算符（<>,!=）
索引只能查找表中已有的数据，所以where子句使用不等式运算符时无法使用索引。

(2)使用 IS NULL 或 IS NOT NULL时
因为NULL值并没有被定义。数据库中没有值等于NULL值；甚至NULL也不等于NULL。

(3)使用函数，在索引列上使用函数改变了索引列的值，也会导致该索引列的索引无法使用。
如果不使用基于函数的索引，那么在SQL语句的WHERE子句中对存在索引的列使用函数时，会使优化器忽略掉这些索引。一些常见的函数，如TRUNC、SUBSTR、TO_DATE、TO_CHAR和INSTR等，都能改变列的值。因此，无法使用已被函数引用的索引和列。下面的语句会执行一次全表扫描，即使hire_date列上存在索引(只要它不是基于函数的索引)。
select empno, ename, deptno from emp where trunc(hiredate) = '01-MAY-01';
把上面的语句改成如下所示的语句，这样就可以通过索引进行查找。
select empno, ename, deptno from emp  where hiredate > '01-MAY-01'and  hiredate < (TO_DATE('01-MAY-01') + 0.99999);
**通过改变所比较的列上的值，而不用改变列本身，就可以启用索引用。这样可避免全表扫描。

（4）比较不匹配的数据类型
如果Account_Number列使用VARCHAR2数据类型，下面的语句将执行全表扫描，即便是索引account_number列：
select bank_name, address, city, state, zip  from  banks   where   account_number = 990354;
Oracle可以自动把WHERE子句变成
to_number(account_number)=990354
通过使用函数(例如TO_DATE或TO_CHAR)修改所比较的列值而不是列本身，就可以使用索引，在对列本身使用函数时就会限制使用这些索引。


6.位图索引
试用于基数较少的列，如两个可能值：男或女(基数仅为2)。
create bitmap index dept_idx2_bm on dept (deptno);

如果索引中被删除的行数达到了20％~25％，就必须重建索引，这样可以减少二元高度和在一次I/O过程中读取的空闲空间量。

如何正确使用索引：

1.索引正确的表和列
。经常检索排序大表中40%或非排序表7%的行，建议建索引；
。为了改善多表关联，索引列用于联结；
。列中的值相对比较唯一；
。取值范围（大：B*树索引，小：位图索引）；
。Date 型列一般适合基于函数的索引；
。列中有许多空值，不适合建立索引

2.为性能而安排索引列
。经常一起使用多个字段检索记录，组合索引比单索引更有效；
。把最常用的列放在最前面，例：dx_groupid_serv_id(groupid,serv_id)，在where 条件
中使用groupid 或groupid,serv_id，查询将使用索引，若仅用到serv_id 字段，则索引无效；
。合并/拆分不必要的索引。

3.限制每个表索引的数量
。一个表可以有几百个索引（你会这样做吗？），但是对于频繁插入和更新表，索引越
多系统CPU，I/O 负担就越重；
。建议每张表不超过5 个索引。

4.删除不再需要的索引
。索引无效，集中表现在该使用基于函数的索引或位图索引，而使用了B*树索引；
。应用中的查询不使用索引；
。重建索引之前必须先删除索引，若用alter index … rebuild 重建索引，则不必删除索引。

5.索引数据块空间使用
。创建索引时指定表空间，特别是在建立主键时，应明确指定表空间；
。合理设定pctfress，注意：不能给索引指定pctused；
。估计索引的大小和合理地设置存储参数，默认为表空间大小，或initial与next设置成
一样大。

6.考虑并行创建索引
。对大表可以采用并行创建索引，在并行创建索引时，存储参数被每个查询服务器进程
分别使用，例如：initial为1M，并行度为8，则创建索引期间至少要消耗8M空间；

7.考虑用nolog
