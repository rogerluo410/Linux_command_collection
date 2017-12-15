# HTTP

 post 传输的数据被截断： http://stackoverflow.com/questions/16934226/jquery-post-request-interrupted-only-half-of-post-parameters-arrive    
 “post 理论上讲是没有大小限制的，HTTP协议规范也没有进行大小限制，但实际上post所能传递的数据量大小取决于服务器的设置和内存大小”    
 
 get 是通过URL提交数据，因此GET可提交的数据量就跟URL所能达到的最大长度有直接关系。很多文章都说GET方式提交的数据最多只能是1024字节，而实际上，URL不存在参数上限的问题，HTTP协议规范也没有对URL长度进行限制。这个限制是特定的浏览器及服务器对它的限制。IE对URL长度的限制是2083字节(2K+35字节)。对于其他浏览器，如FireFox，Netscape等，则没有长度限制，这个时候其限制取决于服务器的操作系统。即如果url太长，服务器可能会因为安全方面的设置从而拒绝请求或者发生不完整的数据请求。
 
post 理论上讲是没有大小限制的，HTTP协议规范也没有进行大小限制，但实际上post所能传递的数据量大小取决于服务器的设置和内存大小。因为我们一般post的数据量很少超过MB的，所以我们很少能感觉的到post的数据量限制，但实际中如果你上传文件的过程中可能会发现这样一个问题，即上传个头比较大的文件到服务器时候，可能上传不上去，以php语言来说，查原因的时候你也许会看到有说PHP上传文件涉及到的参数PHP默认的上传有限定，一般这个值是2MB，更改这个值需要更改php.conf的post_max_size这个值。这就很明白的说明了这个问题了。


# REST / JSON / XML-RPC / SOAP
REST mandates the general semantics and concepts. The transport and encodings are up to you. They were originally formulated on XML, but JSON is totally applicable.

XML-RPC / SOAP are different mechanisms, but mostly the same ideas: how to map OO APIs on top of XML and HTTP. IMHO, they're disgusting from a design view. I was so relieved when found about REST. In your case, i'm sure that the lots of layers would mean a lot more CPU demand.

I'd say go REST, using JSON for encoding; but if your requirements are really that simple as just uploading, then you can use simply HTTP (which might be RESTful in design even without adding any specific library)

> http://stackoverflow.com/questions/1371312/rest-json-xml-rpc-soap   


### HTTP status  
* Informational	   
100	:continue   
101	:switching_protocols   
102	:processing  

* Success	  
200	:ok   
201	:created  
202	:accepted   
203	:non_authoritative_information   
204	:no_content  
205	:reset_content   
206	:partial_content   
207	:multi_status   
208	:already_reported   
226	:im_used   

* Redirection	  
300	:multiple_choices   
301	:moved_permanently   
302	:found   
303	:see_other   
304	:not_modified   
305	:use_proxy   
306	:reserved   
307	:temporary_redirect   
308	:permanent_redirect   

* Client Error	  
400	:bad_request    
401	:unauthorized   
402	:payment_required   
403	:forbidden   
404	:not_found    
405	:method_not_allowed    
406	:not_acceptable   
407	:proxy_authentication_required   
408	:request_timeout   
409	:conflict    
410	:gone   
411	:length_required   
412	:precondition_failed   
413	:request_entity_too_large   
414	:request_uri_too_long   
415	:unsupported_media_type   
416	:requested_range_not_satisfiable   
417	:expectation_failed   
422	:unprocessable_entity   
423	:locked   
424	:failed_dependency   
426	:upgrade_required   
428	:precondition_required   
429	:too_many_requests   
431	:request_header_fields_too_large   

* Server Error	
500	:internal_server_error     
501	:not_implemented   
502	:bad_gateway   
503	:service_unavailable    
504	:gateway_timeout   
505	:http_version_not_supported   
506	:variant_also_negotiates   
507	:insufficient_storage   
508	:loop_detected   
510	:not_extended   
511	:network_authentication_required   


# Crawling  

> http://www.cnblogs.com/junrong624/p/5533655.html  --抓包可能遇到的问题
> https://my.oschina.net/leejun2005/blog/407043  --PhantomJS web抓包引擎
> http://www.tuicool.com/articles/nieEVv  --PhantomJS使用说明

# HTTP request header 

 > http://www.cnblogs.com/yucongblog/p/5885802.html --HTTP消息中request和response的 header头部信息的讲解

### `application/x-www-form-urlencoded`  and  `multipart/form-data`等, 4种常见post提交数据方式 

- application/x-www-form-urlencoded

 1）当action为get时候，浏览器用x-www-form-urlencoded的编码方式把form数据转换成一个字串（name1=value1&name2=value2...），然后把这个字串append到url后面，用?分割，加载这个新的url。  

 2）当action为post时候，浏览器把form数据封装到http body中，然后发送到server。 


- multipart/form-data 

 > http://blog.csdn.net/five3/article/details/7181521  --multipart/form-data 编码格式详解  

采用这种编码方式，浏览器可以很容易的使表单内的数据和文件一起传送。
这种编码方式先定义好一个不可能在数据中出现的字符串作为分界符，然后用它将各个数据段分开，
而对于每个数据段都对应着HTML页面表单中的一个Input区，包括一个content-disposition 属性，
说明了这个数据段的一些信息，如果这个数据段的内容是一个文件，还会有Content-Type属性(image/jpeg...)，然后就是数据本身。   

- application/json
   Content-Type: application/json;charset=utf-8  
   传输序列化后的json字符串到服务端     
   
- text/xml   
   XML-RPC服务, 使用HTTP作为传输协议， XML作为编码方式的远程调用规范。  

 


# Web 的结构组件  
在Web浏览器 和 Web服务器之间，有很多中间组件， 分别是： 
```
 1) 代理
 2) 缓存
 3) 网关
 4) 隧道
 5) Agent 代理
```

# HTTP报文格式     

 - 请求报文  
 ```
 <method> <request-url> <http protocol version>
 <headers>
 
 <entity-body>
 
 eg1: 
 GET /test/hi-there.txt HTTP/1.1     --报文起始行  
 
 Accept: text/*     --报文首部  
 Host: www.xxx.com  
 
 eg2: 
 
 --请求头
 Accept:text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
 Accept-Encoding:gzip, deflate, sdch
 Accept-Language:en-US,en;q=0.8,zh-CN;q=0.6,zh;q=0.4,zh-TW;q=0.2,ja;q=0.2
 Cache-Control:max-age=0
 Connection:keep-alive
 Cookie:PHPSESSID=863619ebcfb4fc267ee3bb4d1426d617
 Host:www.xingfushun.cn
 Referer:https://www.baidu.com/link?url=6dzBGmzwkQfk5mRhKbOL_HuIpQvJK5HW5LOrhTOCc0RFsVScrY-wNQRGctY6h-htLt6XZMPyW38tAdPju8RpDa&wd=&eqid=e1212b3600012e74000000055847a57c
 Upgrade-Insecure-Requests:1
 User-Agent:Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36
 ```
 
 - 响应报文 
 ```
 <http protocol version> <status> <reason-phrase>
 <headers>
 
 <entity-body>
 
 eg:
 HTTP/1.1 200 OK   --报文起始行
 --响应头
 Cache-Control:no-store, no-cache, must-revalidate, post-check=0, pre-check=0
 Connection:Keep-Alive
 Content-Encoding:gzip
 Content-Length:2662
 Content-Type:text/html; charset=utf-8
 Date:Wed, 07 Dec 2016 06:11:33 GMT
 Expires:Thu, 19 Nov 1981 08:52:00 GMT
 Keep-Alive:timeout=1, max=100
 Pragma:no-cache
 Server:Apache/2
 Vary:Accept-Encoding,User-Agent
 X-Powered-By:PHP/5.2.17
 ```
 
# 连接管理  

- TCP的性能  

- HTTP事物的时延 
 
  通过DNS将URI中的主机名转换成IP地址需要花费一点时间。  
  大多数HTTP客户端都有一个DNS缓存，用来保存近期所访问站点的IP地址。  
  
- HTTP连接处理与优化  

 * connection 首部
 * 串行事物处理（串行连接）
 * 并行连接  提高复合页面的传输速度
 * 持久连接  connection: KEEP-ALIVE， 减少打开连接的潜在数量；
 
 
# 代理 

  * 代理和网关的区别 
  
  代理: 
  Web Client --http-->  Web 代理 --http--> Web Server  
  
  
  网关:
  Web Client --http-->  Web/Email网关 --POP--> Web Server  
  
  
# 缓存  
- 缓存优点： 

 1. 减少冗余数据传输， 节省网络带宽
 2. 缓解网络瓶颈， 不需要更多的带宽就能更快的加载页面
 3. 降低对原始服务器的要求， 服务器可以更快响应， 避免过载的出现
 4. 降低距离时延， 因为从较远的地方加载页面会更快一些  
 
- HTTP 关于缓存的首部  
 Cache-Control 首部：
    * no-store 
    * no-cache
    * max-age   
    * must-revalidate    
 
    Cache-Control: no-store     --不存储， 直接删除   
    Cache-Control: no-cache     --可以缓存在本地， 但必须与原始服务器验证成功后才可以使用    
    Cache-Control: max-age=100  --客户端缓存的秒数      
     
 Expires: 服务器响应头告诉浏览器改资源的过期时间。 是http1.0的规范
 
 Etag:  服务器返回的校验串， 决定返回200或304    
 
- 浏览器行为还和用户行为有关   
   Ctrl + F5 刷新页面时， cache-control / Etag 都会无效， 重新从服务器拿资源，返回200.   
 
 
# SSL 隧道 

> http://blog.csdn.net/clh604/article/details/22179907   -- https原理：证书传递、验证和数据加密、解密过程解析


# 客户端识别和cookie机制  

# 基本认证机制

# 重定向和负载均衡
