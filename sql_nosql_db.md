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

7.考虑用nologging 创建索引
。对大表创建索引可以使用nologging来减少重做日志；
。节省重做日志文件的空间；
。缩短创建索引的时间；
。改善了并行创建大索引时的性能。

8.怎样建立最佳索引
明确地创建索引
create index index_name on table_name(field_name)
tablespace tablespace_name
pctfree 5
initrans 2
maxtrans 255
storage
(
minextents 1
maxextents 16382
pctincrease 0
);

9.创建基于函数的索引
。常用与UPPER、LOWER、TO_CHAR(date)等函数分类上，例：
create index idx_func on emp (UPPER(ename)) tablespace tablespace_name;

10.创建位图索引
。对基数较小，且基数相对稳定的列建立索引时，首先应该考虑位图索引，例：
create bitmap index idx_bitm on class (classno) tablespace tablespace_name;

11.明确地创建唯一索引
。可以用create unique index 语句来创建唯一索引，例：
create unique index dept_unique_idx on dept(dept_no) tablespace idx_1;

12.创建与约束相关的索引
。可以用using index字句，为与unique和primary key约束相关的索引，例如：
alter table table_name
add constraint PK_primary_keyname primary key (field_name)
using index tablespace tablespace_name；

13.重建现存的索引
重建现存的索引的当前时刻不会影响查询；
重建索引可以删除额外的数据块；
提高索引查询效率；
alter index idx_name rebuild nologging;
对于分区索引：
alter index idx_name rebuild partition partiton_name nologging;

14.要删除索引的原因
。不再需要的索引；
。索引没有针对其相关的表所发布的查询提供所期望的性能改善；
。应用没有用该索引来查询数据；
。该索引无效，必须在重建之前删除该索引；
。该索引已经变的太碎了，必须在重建之前删除该索引；
。语句：drop index idx_name;drop index idx_name drop partition partition_name;

15.建立索引的代价
基础表维护时，系统要同时维护索引，不合理的索引将严重影响系统资源，主要表现在
CPU和I/O上；
插入、更新、删除数据产生大量db file sequential read锁等待；

16.索引访问
。最常用的方法，包括索引唯一扫描和索引范围扫描，OLTP；
快速完全索引扫描
。访问索引中所有数据块，结果相当于全表扫描，可以用索引扫描代替全表扫描，例如：
Select serv_id,count(* ) from tg_cdr01 group by serv_id;
评估全表扫描的合法性

17.如何实现并行扫描
。永久并行化（不推荐）
alter table customer parallel degree 8;
。单个查询并行化
select /*+ full(emp) parallel(emp,8)*/ * from emp;
```

* Sql优化   
```
1.减少访问数据库的次数： 
ORACLE在内部执行了许多工作: 解析SQL语句, 估算索引的利用率, 绑定变量 , 读数据块等。

2.整合简单,无关联的数据库访问： 
如果你有几个简单的数据库查询语句,你可以把它们整合到一个查询中(即使它们之间没有关系) 

3.删除重复记录： 
最高效的删除重复记录方法 ( 因为使用了ROWID)例子： 
DELETE FROM EMP E WHERE E.ROWID > (SELECT MIN(X.ROWID) 
FROM EMP X WHERE X.EMP_NO = E.EMP_NO); 

4.用TRUNCATE替代DELETE： 
当删除表中的记录时,在通常情况下, 回滚段(rollback segments ) 用来存放可以被恢复的信息. 如果你没有COMMIT事务,ORACLE会将数据恢复到删除之前的状态(准确地说是恢复到执行删除命令之前的状况) 而当运用TRUNCATE时, 回滚段不再存放任何可被恢复的信息.当命令运行后,数据不能被恢复.因此很少的资源被调用,执行时间也会很短. (译者按: TRUNCATE只在删除全表适用,TRUNCATE是DDL不是DML) 

5.尽量多使用COMMIT： 
只要有可能,在程序中尽量多使用COMMIT, 这样程序的性能得到提高,需求也会因为COMMIT所释放的资源而减少: 
COMMIT所释放的资源: 
a. 回滚段上用于恢复数据的信息. 
b. 被程序语句获得的锁 
c. redo log buffer 中的空间 
d. ORACLE为管理上述3种资源中的内部花费 

6.用EXISTS替代IN、用NOT EXISTS替代NOT IN： 
在许多基于基础表的查询中,为了满足一个条件,往往需要对另一个表进行联接.在这种情况下, 使用EXISTS(或NOT EXISTS)通常将提高查询的效率. 在子查询中,NOT IN子句将执行一个内部的排序和合并. 无论在哪种情况下,NOT IN都是最低效的 (因为它对子查询中的表执行了一个全表遍历). 为了避免使用NOT IN ,我们可以把它改写成外连接(Outer Joins)或NOT EXISTS. 
例子： 
（高效）SELECT * FROM EMP (基础表) WHERE EMPNO > 0 AND EXISTS (SELECT ‘X' FROM DEPT WHERE DEPT.DEPTNO = EMP.DEPTNO AND LOC = ‘MELB') 
(低效)SELECT * FROM EMP (基础表) WHERE EMPNO > 0 AND DEPTNO IN(SELECT DEPTNO FROM DEPT WHERE LOC = ‘MELB') 

7.用EXISTS替换DISTINCT： 
当提交一个包含一对多表信息(比如部门表和雇员表)的查询时,避免在SELECT子句中使用DISTINCT. 一般可以考虑用EXIST替换, EXISTS 使查询更为迅速,因为RDBMS核心模块将在子查询的条件一旦满足后,立刻返回结果. 例子： 
(低效): 
SELECT DISTINCT DEPT_NO,DEPT_NAME FROM DEPT D , EMP E 
WHERE D.DEPT_NO = E.DEPT_NO 
(高效): 
SELECT DEPT_NO,DEPT_NAME FROM DEPT D WHERE EXISTS ( SELECT ‘X' 
FROM EMP E WHERE E.DEPT_NO = D.DEPT_NO); 

8.用>=替代> 
高效: 
SELECT * FROM EMP WHERE DEPTNO >=4 
低效: 
SELECT * FROM EMP WHERE DEPTNO >3 
两者的区别在于, 前者DBMS将直接跳到第一个DEPT等于4的记录而后者将首先定位到DEPTNO=3的记录并且向前扫描到第一个DEPT大于3的记录. 

9.需要当心的WHERE子句: 
某些SELECT 语句中的WHERE子句不使用索引. 这里有一些例子. 
在下面的例子里, 
(1)‘!=' 将不使用索引. 记住, 索引只能告诉你什么存在于表中, 而不能告诉你什么不存在于表中. 
(2)‘||'是字符连接函数. 就象其他函数那样, 停用了索引. 
(3)‘+'是数学函数. 就象其他数学函数那样, 停用了索引. 
(4)相同的索引列不能互相比较,这将会启用全表扫描. 

10.避免改变索引列的类型.: 
当比较不同数据类型的数据时, ORACLE自动对列进行简单的类型转换. 
假设 EMPNO是一个数值类型的索引列. 
SELECT … FROM EMP WHERE EMPNO = ‘123' 
实际上,经过ORACLE类型转换, 语句转化为: 
SELECT … FROM EMP WHERE EMPNO = TO_NUMBER(‘123') 
幸运的是,类型转换没有发生在索引列上,索引的用途没有被改变. 
现在,假设EMP_TYPE是一个字符类型的索引列. 
SELECT … FROM EMP WHERE EMP_TYPE = 123 
这个语句被ORACLE转换为: 
SELECT … FROM EMP WHERE  TO_NUMBER(EMP_TYPE)=123 
因为内部发生的类型转换, 这个索引将不会被用到! 为了避免ORACLE对你的SQL进行隐式的类型转换, 最好把类型转换用显式表现出来. 注意当字符和数值比较时, ORACLE会优先转换字符类型 到 数值类型。 和c语言的类型转换一样

11.优化GROUP BY: 
提高GROUP BY 语句的效率, 可以通过将不需要的记录在GROUP BY 之前过滤掉.下面两个查询返回相同结果但第二个明显就快了许多. 
低效: 
SELECT JOB , AVG(SAL) 
FROM EMP 
GROUP by JOB 
HAVING JOB = ‘PRESIDENT' 
OR JOB = ‘MANAGER' 
高效: 
SELECT JOB , AVG(SAL) 
FROM EMP 
WHERE JOB = ‘PRESIDENT' 
OR JOB = ‘MANAGER' 
GROUP by JOB 
```

* 优化SQL语句排序
```
排序的操作：
。order by 子句
。group by 子句
。select distinct子句
。创建索引时
。union或minus
。排序合并连接
如何避免排序
。添加索引
。在索引中使用distinct子句
。避免排序合并连接
```

* 使用提示进行调整
```
使用提示的原则
。语法：/*+ hint */
。使用表别名:select /*+ index(e dept_idx)*/ * from emp e
。检验提示
常用的提示
。rule
。all_rows
。first_rows
。use_nl
。use_hash( a b)
。use_merge
。index
。index_asc
。no_index
。index_desc（常用于使用max内置函数）
。index_combine(强制使用位图索引)
。index_ffs（索引快速完全扫描）
。use_concat(将查询中所有or条件使用union all)
。parallel
。noparallel
。full
。ordered（基于成本）
```

#数据库知识概念     

**乐观锁 和 悲观锁**   
> http://blog.codingnow.com/2014/12/skynet_spinlock.html   

```
悲观锁(Pessimistic Lock), 顾名思义，就是很悲观，每次去拿数据的时候都认为别人会修改，所以每次在拿数据的时候都会上锁，这样别人想拿这个数据就会block直到它拿到锁。传统的关系型数据库里边就用到了很多这种锁机制，比如行锁，表锁等，读锁，写锁等，都是在做操作之前先上锁。



乐观锁(Optimistic Lock), 顾名思义，就是很乐观，每次去拿数据的时候都认为别人不会修改，所以不会上锁，但是在更新的时候会判断一下在此期间别人有没有去更新这个数据，可以使用版本号等机制。乐观锁适用于多读的应用类型，这样可以提高吞吐量，像数据库如果提供类似于write_condition机制的其实都是提供的乐观锁。



两种锁各有优缺点，不可认为一种好于另一种，像乐观锁适用于写比较少的情况下，即冲突真的很少发生的时候，这样可以省去了锁的开销，加大了系统的整个吞吐量。但如果经常产生冲突，上层应用会不断的进行retry，这样反倒是降低了性能，所以这种情况下用悲观锁就比较合适。
```  

**关系型数据库的表链接**  
```
表之间的连接分为三种：
1. 内连接(自然连接)
2. 外连接
（1）左外连接 (左边的表不加限制)
（2）右外连接(右边的表不加限制)
（3）全外连接(左右两表都不加限制)
3. 自连接（同一张表内的连接）

SQL的标准语法：
	select table1.column,table2.column
	from table1 [inner | left | right | full ] join table2 on table1.column1 = table2.column2;

inner join 表示内连接；
left join表示左外连接；
right join表示右外连接；
full join表示完全外连接；
on子句 用于指定连接条件。

注意：
如果使用from子句指定内、外连接，则必须要使用on子句指定连接条件；
如果使用（+）操作符指定外连接，则必须使用where子句指定连接条件。
```

**SQL谓词**   
```
1、谓词 谓词允许您构造条件，以便只处理满足这些条件的那些行。

2、使用 IN 谓词
使用 IN 谓词将一个值与其他几个值进行比较。例如：
SELECT NAME FROM STAFF WHERE DEPT IN (20, 15)
此示例相当于：
SELECT NAME FROM STAFF WHERE DEPT = 20 OR DEPT = 15

当子查询返回一组值时，可使用 IN 和 NOT IN 运算符。例如，下列查询列出负责项目 MA2100 和 OP2012 的雇员的姓：
SELECT LASTNAME FROM EMPLOYEE WHERE EMPNO IN (SELECT RESPEMP FROM PROJECT WHERE PROJNO='MA2100' OR PROJNO='OP2012')

计算一次子查询，并将结果列表直接代入外层查询。例如，上面的子查询选择雇员编号 10 和 330，对外层查询进行计算，就好象 WHERE 子句如下：
WHERE EMPNO IN (10, 330)
子查询返回的值列表可包含零个、一个或多个值。

3、使用 BETWEEN 谓词
使用 BETWEEN 谓词将一个值与某个范围内的值进行比较。范围两边的值是包括在内的，并考虑 BETWEEN 谓词中用于比较的两个表达式。
下一示例寻找收入在 $10,000 和 $20,000 之间的雇员的姓名：

SELECT LASTNAME FROM EMPLOYEE WHERE SALARY BETWEEN 10000 AND 20000
这相当于：
SELECT LASTNAME FROM EMPLOYEE WHERE SALARY >= 10000 AND SALARY <= 20000

下一个示例寻找收入少于 $10,000 或超过 $20,000 的雇员的姓名：
SELECT LASTNAME FROM EMPLOYEE WHERE SALARY NOT BETWEEN 10000 AND 20000

4、使用 LIKE 谓词
使用 LIKE 谓词搜索具有某些模式的字符串。通过百分号和下划线指定模式。
下划线字符(_)表示任何单个字符，百分号(%)表示零或多个字符的字符串。
任何其他表示本身的字符。

下列示例选择以字母\'S\'开头长度为 7 个字母的雇员名：
SELECT NAME FROM STAFF WHERE NAME LIKE \'S_ _ _ _ _ _\'

下一个示例选择不以字母\'S\'开头的雇员名：
SELECT NAME FROM STAFF WHERE NAME NOT LIKE \'S%\'

5、使用 EXISTS 谓词
可使用子查询来测试满足某个条件的行的存在性。在此情况下，谓词 EXISTS 或 NOT EXISTS 将子查询链接到外层查询。
当用 EXISTS 谓词将子查询链接到外层查询时，该子查询不返回值。相反，如果子查询的回答集包含一个或更多个行，则 EXISTS 谓词为真；如果回答集不包含任何行，则 EXISTS 谓词为假。
通常将 EXISTS 谓词与相关子查询一起使用。下面示例列出当前在项目(PROJECT) 表中没有项的部门：

SELECT DEPTNO, DEPTNAME FROM DEPARTMENT X WHERE NOT EXISTS (SELECT *FROM PROJECT WHERE DEPTNO = X.DEPTNO) ORDER BY DEPTNO

可通过在外层查询的 WHERE 子句中使用 AND 和 OR 将 EXISTS 和 NOT EXISTS 谓词与其他谓词连接起来。

6、定量谓词
定量谓词将一个值和值的集合进行比较。如果全查询返回多个值，则必须通过附加后缀 ALL、ANY 或 SOME 来修改谓词中的比较运算符。这些后缀确定如何在外层谓词中处理返回的这组值。使用>比较运算符作为示例（下面的注释也适用于其他运算符）：

表达式 > ALL （全查询）
如果该表达式大于由全查询返回的每个单值，则该谓词为真。如果全查询未返回值，则该谓词为真。如果指定的关系至少对一个值为假，则结果为假。注意：<>ALL 定量谓词相当于 NOT IN 谓词。
下列示例使用子查询和> ALL 比较来寻找收入超过所有经理的所有雇员的姓名和职业：
SELECT LASTNAME, JOB FROM EMPLOYEE WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEE WHERE JOB=\'MANAGER\')

表达式 > ANY （全查询）
如果表达式至少大于由全查询返回的值之一，则该谓词为真。如果全查询未返回值，则该谓词为假。注意：=ANY 定量运算符相当于 IN 谓词。

表达式 > SOME（全查询）
SOME 与 ANY 同义。
```
  
**范式**  
`第一范式（1NF）`: 数据库表中的字段都是单一属性的，不可再分。    

`第二范式（2NF）`: 数据库表中不存在非关键字段对任一候选关键字段的部分函数依赖。  

`第三范式（3NF）`: 在第二范式的基础上，数据表中如果不存在非关键字段对任一候选关键字段的传递函数依赖则符合第三范式。所谓传递函数依赖，指的是如果存在"A → B → C"的决定关系，则C传递函数依赖于A。    

`鲍依斯-科得范式（BCNF）` : 在第三范式的基础上，数据库表中如果不存在任何字段对任一候选关键字段的传递函数依赖则符合第三范式。    



   
