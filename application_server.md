#Nginx for Mac    
* Install       
  `brew install nginx`   
  `nginx -V`    --查看版本，以及配置文件地址     

* 配置文件地址: `/usr/local/etc/nginx/nginx.conf`     

* 重新加载配置|重启|停止|退出 nginx     
  `nginx -s reload|reopen|stop|quit`       


#squid,nginx,lighttpd, varnish反向代理的区别   
> http://www.cnblogs.com/yihang/archive/2010/12/19/1910363.html  

同步传输：浏览器发起请求，而后请求会立刻被转到后台，于是在浏览器和后台之间就建立了一个通道。在请求发起直到请求完成，这条通道都是一直存在的。
异步传输：浏览器发起请求，请求不会立刻转到后台，而是将请求数据（header）先收到nginx上，然后nginx再把这个请求发到后端，后端处理完之后把数据返回到nginx上，nginx将数据流发到浏览器，这点和lighttpd有点不同，lighttpd是将后端数据完全接收后才发送到浏览器。

小结：apache和squid的反向会增加后端web的负担，因为每个用户请求都会在proxy上与后端server建立的长久链接，直到数据取完前，连接都不会消失。因为wan速度与lan速度的不同，虽然lan之间的速度是极度快的，但是用户的wan连接决定了这个时间长短。而lighttpd和nginx的异步模式，是不管你用户要求的数据有多大，都是先收下来，再与后端联系，这是非常迅速的速度，所以proxy与后端连接时间也会很短，几十M的东西也是几秒内。后端不需要维护这么多连接。而lighttpd也和nginx不同的异步，lighttpd是先收完再转向客户浏览器，而nginx是边收数据边转向用户浏览器。
