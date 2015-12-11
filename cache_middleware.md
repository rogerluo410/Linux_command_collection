#Redis    
Desc:  Redis 是一款依据BSD开源协议发行的高性能Key-Value存储系统（cache and store）。它通常被称为数据结构服务器，因为值（value）可以是 字符串(String), 哈希(hashes), 列表(list), 集合(sets) 和 有序集合(sorted sets)等类型。  

Learning Redis:  
> http://try.redis.io/   

中文文档:  
> http://doc.redisfans.com/  
> http://www.redis.cn/  

Redis客户端管理工具： Redis Desktop Manager   

* Install on OSX : 
  `brew install redis`  

* 设置开机启动redis服务:
  ***mac 上是没有init.d 目录的，mac启动脚本是 以.plist 结尾***  
  `brew info redis` 可以获得更多相关信息  
  
* 启动redis服务:  
  `redis-server /usr/local/etc/redis.conf`  
