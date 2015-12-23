#Redis    
Desc:  Redis 是一款依据BSD开源协议发行的高性能Key-Value存储系统（cache and store）。它通常被称为数据结构服务器，因为值（value）可以是 字符串(String), 哈希(hashes), 列表(list), 集合(sets) 和 有序集合(sorted sets)等类型。  

Learning Redis:  
> http://try.redis.io/   

中文文档:  
> http://doc.redisfans.com/  
> http://www.redis.cn/  
> http://redis.io/commands  --command reference   
> http://redis.io/documentation  --Programming with Redis   

* Install on OSX : 
  `brew install redis`  

* 设置开机启动redis服务:
  ***mac 上是没有init.d 目录的，mac启动脚本是 以.plist 结尾***  
  `brew info redis` 可以获得更多相关信息  
  
* 启动redis服务:  
  `redis-server /usr/local/etc/redis.conf`  
  `redis-cli` 客户端命令    
  Redis客户端管理工具： Redis Desktop Manager     

* Instructions:  
```
著作权归作者所有。
商业转载请联系作者获得授权，非商业转载请注明出处。
作者：seamon
链接：http://www.zhihu.com/question/19645807/answer/12605611
来源：知乎

mongodb和memcached不是一个范畴内的东西。mongodb是文档型的非关系型数据库，其优势在于查询功能比较强大，能存储海量数据。mongodb和memcached不存在谁替换谁的问题。和memcached更为接近的是redis。它们都是内存型数据库，数据保存在内存中，通过tcp直接存取，优势是速度快，并发高，缺点是数据类型有限，查询功能不强，一般用作缓存。在我们团队的项目中，一开始用的是memcached，后来用redis替代。
相比memcached：
1、redis具有持久化机制，可以定期将内存中的数据持久化到硬盘上。
2、redis具备binlog功能，可以将所有操作写入日志，当redis出现故障，可依照binlog进行数据恢复。
3、redis支持virtual memory，可以限定内存使用大小，当数据超过阈值，则通过类似LRU的算法把内存中的最不常用数据保存到硬盘的页面文件中。
4、redis原生支持的数据类型更多，使用的想象空间更大。
5、前面有位朋友所提及的一致性哈希，用在redis的sharding中，一般是在负载非常高需要水平扩展时使用。我们还没有用到这方面的功能，一般的项目，单机足够支撑并发了。redis 3.0将推出cluster，功能更加强大。  



著作权归作者所有。
商业转载请联系作者获得授权，非商业转载请注明出处。
作者：iammutex
链接：http://www.zhihu.com/question/19645807/answer/14107242
来源：知乎

Redis相对Memcached来说功能和特性上的优势已经很明显了。而对于性能，Redis作者的说法是平均到单个核上的性能，在单条数据不大的情况下Redis更好。为什么这么说呢，理由就是Redis是单线程运行的。因为是单线程运行，所以和Memcached的多线程相比，整体性能肯定会偏低。因为是单线程运行，所以IO是串行化的，网络IO和内存IO，因此当单条数据太大时，由于需要等待一个命令的所有IO完成才能进行后续的命令，所以性能会受影响。而就内存使用上来说，目前Redis结合了tcmalloc和jemalloc两个内存分配器，基本上和Memcached不相伯仲。如果是简单且有规律的key value存储，那么用Redis的hash结构来做，内存使用上会惊人的变小，优势是很明显的。


memcached和redis的比较
1 网络IO模型
　　Memcached是多线程，非阻塞IO复用的网络模型，分为监听主线程和worker子线程，监听线程监听网络连接，接受请求后，将连接描述字pipe 传递给worker线程，进行读写IO, 网络层使用libevent封装的事件库，多线程模型可以发挥多核作用，但是引入了cache coherency和锁的问题，比如，Memcached最常用的stats 命令，实际Memcached所有操作都要对这个全局变量加锁，进行计数等工作，带来了性能损耗。

　　Redis使用单线程的IO复用模型，自己封装了一个简单的AeEvent事件处理框架，主要实现了epoll、kqueue和select，对于单纯只有IO操作来说，单线程可以将速度优势发挥到最大，但是Redis也提供了一些简单的计算功能，比如排序、聚合等，对于这些操作，单线程模型实际会严重影响整体吞吐量，CPU计算过程中，整个IO调度都是被阻塞住的。

2.内存管理方面
　　Memcached使用预分配的内存池的方式，使用slab和大小不同的chunk来管理内存，Item根据大小选择合适的chunk存储，内存池的方式可以省去申请/释放内存的开销，并且能减小内存碎片产生，但这种方式也会带来一定程度上的空间浪费，并且在内存仍然有很大空间时，新的数据也可能会被剔除，原因可以参考Timyang的文章：http://timyang.net/data/Memcached-lru-evictions/
　　Redis使用现场申请内存的方式来存储数据，并且很少使用free-list等方式来优化内存分配，会在一定程度上存在内存碎片，Redis跟据存储命令参数，会把带过期时间的数据单独存放在一起，并把它们称为临时数据，非临时数据是永远不会被剔除的，即便物理内存不够，导致swap也不会剔除任何非临时数据(但会尝试剔除部分临时数据)，这点上Redis更适合作为存储而不是cache。

3.数据一致性问题
　　Memcached提供了cas命令，可以保证多个并发访问操作同一份数据的一致性问题。 Redis没有提供cas 命令，并不能保证这点，不过Redis提供了事务的功能，可以保证一串 命令的原子性，中间不会被任何操作打断。

4.存储方式及其它方面
　　Memcached基本只支持简单的key-value存储，不支持枚举，不支持持久化和复制等功能
　　Redis除key/value之外，还支持list,set,sorted set,hash等众多数据结构，提供了KEYS
　　进行枚举操作，但不能在线上使用，如果需要枚举线上数据，Redis提供了工具可以直接扫描其dump文件，枚举出所有数据，Redis还同时提供了持久化和复制等功能。
　　
　　
传统MySQL+ Memcached架构遇到的问题
　　实际MySQL是适合进行海量数据存储的，通过Memcached将热点数据加载到cache，加速访问，很多公司都曾经使用过这样的架构，但随着业务数据量的不断增加，和访问量的持续增长，我们遇到了很多问题：
　　1.MySQL需要不断进行拆库拆表，Memcached也需不断跟着扩容，扩容和维护工作占据大量开发时间。
　　2.Memcached与MySQL数据库数据一致性问题。
　　3.Memcached数据命中率低或down机，大量访问直接穿透到DB，MySQL无法支撑。
　　4.跨机房cache同步问题。
　　众多NoSQL百花齐放，如何选择
　　最近几年，业界不断涌现出很多各种各样的NoSQL产品，那么如何才能正确地使用好这些产品，最大化地发挥其长处，是我们需要深入研究和思考的问题，实际归根结底最重要的是了解这些产品的定位，并且了解到每款产品的tradeoffs，在实际应用中做到扬长避短，总体上这些NoSQL主要用于解决以下几种问题
　　1.少量数据存储，高速读写访问。此类产品通过数据全部in-momery 的方式来保证高速访问，同时提供数据落地的功能，实际这正是Redis最主要的适用场景。
　　2.海量数据存储，分布式系统支持，数据一致性保证，方便的集群节点添加/删除。
　　3.这方面最具代表性的是dynamo和bigtable 2篇论文所阐述的思路。前者是一个完全无中心的设计，节点之间通过gossip方式传递集群信息，数据保证最终一致性，后者是一个中心化的方案设计，通过类似一个分布式锁服务来保证强一致性,数据写入先写内存和redo log，然后定期compat归并到磁盘上，将随机写优化为顺序写，提高写入性能。
　　4.Schema free，auto-sharding等。比如目前常见的一些文档数据库都是支持schema-free的，直接存储json格式数据，并且支持auto-sharding等功能，比如mongodb。
　　面对这些不同类型的NoSQL产品,我们需要根据我们的业务场景选择最合适的产品。
　　Redis适用场景，如何正确的使用
　　前面已经分析过，Redis最适合所有数据in-momory的场景，虽然Redis也提供持久化功能，但实际更多的是一个disk-backed的功能，跟传统意义上的持久化有比较大的差别，那么可能大家就会有疑问，似乎Redis更像一个加强版的Memcached，那么何时使用Memcached,何时使用Redis呢?
 
如果简单地比较Redis与Memcached的区别，大多数都会得到以下观点：

1  Redis不仅仅支持简单的k/v类型的数据，同时还提供list，set，zset，hash等数据结构的存储。

2  Redis支持数据的备份，即master-slave模式的数据备份。

3  Redis支持数据的持久化，可以将内存中的数据保持在磁盘中，重启的时候可以再次加载进行使用。

抛开这些，可以深入到Redis内部构造去观察更加本质的区别，理解Redis的设计。

在Redis中，并不是所有的数据都一直存储在内存中的。这是和Memcached相比一个最大的区别。Redis只会缓存所有的 key的信息，如果Redis发现内存的使用量超过了某一个阀值，将触发swap的操作，Redis根据“swappability = age*log(size_in_memory)”计 算出哪些key对应的value需要swap到磁盘。然后再将这些key对应的value持久化到磁盘中，同时在内存中清除。这种特性使得Redis可以 保持超过其机器本身内存大小的数据。当然，机器本身的内存必须要能够保持所有的key，毕竟这些数据是不会进行swap操作的。同时由于Redis将内存 中的数据swap到磁盘中的时候，提供服务的主线程和进行swap操作的子线程会共享这部分内存，所以如果更新需要swap的数据，Redis将阻塞这个 操作，直到子线程完成swap操作后才可以进行修改。

使用Redis特有内存模型前后的情况对比：
VM off: 300k keys, 4096 bytes values: 1.3G used
VM on:  300k keys, 4096 bytes values: 73M used
VM off: 1 million keys, 256 bytes values: 430.12M used
VM on:  1 million keys, 256 bytes values: 160.09M used
VM on:  1 million keys, values as large as you want, still: 160.09M used

当 从Redis中读取数据的时候，如果读取的key对应的value不在内存中，那么Redis就需要从swap文件中加载相应数据，然后再返回给请求方。 这里就存在一个I/O线程池的问题。在默认的情况下，Redis会出现阻塞，即完成所有的swap文件加载后才会相应。这种策略在客户端的数量较小，进行 批量操作的时候比较合适。但是如果将Redis应用在一个大型的网站应用程序中，这显然是无法满足大并发的情况的。所以Redis运行我们设置I/O线程 池的大小，对需要从swap文件中加载相应数据的读取请求进行并发操作，减少阻塞的时间。

如果希望在海量数据的环境中使用好Redis，我相信理解Redis的内存设计和阻塞的情况是不可缺少的。　　

http://blog.csdn.net/tonysz126/article/details/8280696/
```


**All commands of Redis**  
```
DECR
DECRBY
DEL
EXISTS
EXPIRE
GET
GETSET
HDEL
HEXISTS
HGET
HGETALL
HINCRBY
HKEYS
HLEN
HMGET
HMSET
HSET
HVALS
INCR
INCRBY
KEYS
LINDEX
LLEN
LPOP
LPUSH
LRANGE
LREM
LSET
LTRIM
MGET
MSET
MSETNX
MULTI
PEXPIRE
RENAME
RENAMENX
RPOP
RPOPLPUSH
RPUSH
SADD
SCARD
SDIFF
SDIFFSTORE
SET
SETEX
SETNX
SINTER
SINTERSTORE
SISMEMBER
SMEMBERS
SMOVE
SORT
SPOP
SRANDMEMBER
SREM
SUNION
SUNIONSTORE
TTL
TYPE
ZADD
ZCARD
ZCOUNT
ZINCRBY
ZRANGE
ZRANGEBYSCORE
ZRANK
ZREM
ZREMRANGEBYSCORE
ZREVRANGE
ZSCORE
```  

**事务与atomic operation原子操作**  
MULTI 、 EXEC 、 DISCARD 和 WATCH 命令是 Redis 事务的基础。   
* MULTI 命令用于开启一个事务，它总是返回 OK 。 Redis 不支持回滚（roll back）   

* 当执行 DISCARD 命令时， 事务会被放弃， 事务队列会被清空， 并且客户端会从事务状态中退出   

* 使用 check-and-set 操作实现乐观锁, WATCH 命令可以为 Redis 事务提供 check-and-set （CAS）行为。  
  ```
  WATCH mykey

  val = GET mykey
  val = val + 1

  MULTI
  SET mykey $val
  EXEC
  ```
  使用上面的代码， 如果在 WATCH 执行之后， EXEC 执行之前， 有其他客户端修改了 mykey 的值， 那么当前客户端的事务就会失败。 程序需要做的， 就是不断重试这个操作， 直到没有发生碰撞为止。  
  
  
  
**Basic Commands**  
* 设置键值对  
` set v1:backend:name "fido" `  --v1:backend 为域名   
* 获得键值对的值  
` get v1:backend:name`   
* SET-if-not-exists  that sets a key only if it does not already exist   
` setnx v1 15`  --成功返回1，失败返回0  
* 自增命令INCR, INCR to `atomically` increment a number stored at a given key  
` INCR v1`  => 16  
` INCRBY v1 10`  => 25
```
There is something special about INCR. Why do we provide such an operation if we can do it ourself with a bit of code? After all it is as simple as:

x = GET count
x = x + 1
SET count x
The problem is that doing the increment in this way will only work as long as there is a single client using the key. See what happens if two clients are accessing this key at the same time:

Client A reads count as 10.
Client B reads count as 10.
Client A increments 10 and sets count to 11.
Client B increments 10 and sets count to 11.

We wanted the value to be 12, but instead it is 11! This is because incrementing the value in this way is not an atomic operation. Calling the INCR command in Redis will prevent this from happening, because it is an atomic operation. Redis provides many of these atomic operations on different types of data.
```  

* 设置key的生存期, expire , ttl 
```
 set num 10
 expire num 100  --100 单位为秒， 意为100秒后过期   
 ttl num   --返回剩余秒数， 如果过期返回-2 ， 如果返回-1 表示永不过期  
 
 Note that if you SET a key once again, its TTL will be reset and invalid.  
```

* Redis 也提供了一些复杂结构，如链表，集合，有序集合，哈希表等  
1.链表list
· 创建list 
`rpush new_list "a"` --右插入元素a，也可以说是末插入  
`lpush new_list "b"` --左插入元素b，也可以说是头插入  
· 遍历list  
`lrange new_list 0 -1`  --取subset   
· list长度 
`llen new_list`  
·删除元素 
`rpop new_list`  --尾删除一个元素, 并返回被删除元素     
`lpop new_list` --头删除一个元素, 并返回被删除元素   

2.集合set 
· 创建集合set  
`sadd new_set "first"`  --创建一个set， 并加入第一个元素  
· 删除集合中的元素  
`srem new_set "first"`  --删除值为first的元素   
· 查看一个元素是否在集合中
`sismember new_set "first"`  --存在返回1， 不在返回0   
· 遍历集合  
`smembers new_set`  --遍历集合中的所有元素  
· 合并两个集合 
`sunion set1 set2`  --返回一个新集合包含set1,set2的元素， 但是set1, set2并未改变   

3.有序集合 sorted set  
· 创建有序集合 zset  
`zadd sset 100 "first"` --有序集合中， 每一个元素都有一个权值， 会根据这个score排序   
```
127.0.0.1:6379> zadd sset_1 100 "one"
(integer) 1
127.0.0.1:6379> zadd sset_1 200 "two"
(integer) 1
127.0.0.1:6379> zadd sset_1 300 "three"
(integer) 1
127.0.0.1:6379> zadd sset_1 50 "zero"
(integer) 1
127.0.0.1:6379> zrange sset_1 0 -1
1) "zero"
2) "one"
3) "two"
4) "three"

127.0.0.1:6379> zadd sset_1 -14 "minus"
(integer) 1
127.0.0.1:6379> zrange sset_1 0 -1
1) "minus"
2) "zero"
3) "one"
4) "two"
5) "three"

新增相同的权值   
127.0.0.1:6379> zadd sset_1 -14 "minus1"
(integer) 1
127.0.0.1:6379> zrange sset_1 0 -1
1) "minus"
2) "minus1"
3) "zero"
4) "one"
5) "two"
6) "three"
```
· 遍历集合 或 取子集  
`zrange sset_1 0 -1`   

* 哈希表 hash
· 建立hash表  
```
hset user:1 name "roger"
hset user:1 age 18     

一次初始化写法:  
hmset user:1  name "roger"  age 18  

user:1 这种写法可以表示为数组形式的hash表 => [user1, user2, user3, user4,..., userN] 
```
· 遍历hash表 
`hgetall user:1` 获取所有的key-value  user实际只是域名， 所以无法`hgetall user`.  
```
127.0.0.1:6379> hgetall user:1
1) "name"
2) "roger"
3) "age"
4) "18"
```
`hget user:1 name` 获取某个键key的值   
```
127.0.0.1:6379> hget user:1 name
"roger"
```

· hash 字符型value的自增， 原子操作 
`hset user:1 age 18 `  
`hincrby user:1 age  10` => 28   

· 删除某个键key 
```
HSET user:1000 visits 10
HINCRBY user:1000 visits 1 => 11
HINCRBY user:1000 visits 10 => 21
HDEL user:1000 visits
HINCRBY user:1000 visits 1 => 1
```

· 遍历所有的keys  
```
127.0.0.1:6379> hkeys user:1
1) "name"
2) "age"
```




 




