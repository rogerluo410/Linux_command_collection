#Postgresql  
* Installing On OSX :  brew install postgresql -v  
* Initialize Postgresql server : initdb /usr/local/var/postgres -E utf8    --指定 "/usr/local/var/postgres" 为 PostgreSQL 的配置数据存放目录，并且设置数据库数据编码是 utf8，更多配置信息可以 "initdb --help" 查看   

* Set startup When Computer starts :
```
  ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```
* StartUp : pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start    
* Close:  pg_ctl -D /usr/local/var/postgres stop -s -m fast   
* Create db    : createdb dbname -O username -E UTF8 -e  
* Access to    : psql -U username -d dbname -h 127.0.0.1  
* List         : psql -l  
* Access one   : \c dbname  
* Show tables : \d  


#MongoDB   
Description:  MongoDB是一个面向文档的数据库    
  > docs  :  https://docs.mongodb.org    
  > basic command :  http://www.cnblogs.com/TankMa/archive/2011/06/08/2074947.html  
                  :  http://www.cnblogs.com/zengen/archive/2011/04/23/2025722.html   
  
* Installing on OSX:    
   brew install mongodb  
* 启动MongoDB:  
   mongod --config /usr/local/etc/mongod.conf  
* Access to MongoDB with Command:  
   mongo    
`MongoDb的可视化管理工具:  Robomongo   `  

###Mongo command:   
* db.help()          (Show help for database methods)   
* show dbs           (show disk usage)  
* show collections   (Print a list of all collections for current database)  
* show databases     (Print a list of all available databases)      

   
