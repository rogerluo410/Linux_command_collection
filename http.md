# HTTP


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

# HTTP request header for form   

 > http://www.cnblogs.com/yucongblog/p/5885802.html --HTTP消息中request和response的 header头部信息的讲解

### `application/x-www-form-urlencoded`  and  `multipart/form-data`  

- x-www-form-urlencoded

 * 当action为get时候，浏览器用x-www-form-urlencoded的编码方式把form数据转换成一个字串（name1=value1&name2=value2...），然后把这个字串append到url后面，用?分割，加载这个新的url。  

 * 当action为post时候，浏览器把form数据封装到http body中，然后发送到server。 


- multipart/form-data 

 > http://blog.csdn.net/five3/article/details/7181521  --multipart/form-data 编码格式详解  

采用这种编码方式，浏览器可以很容易的使表单内的数据和文件一起传送。

这种编码方式先定义好一个不可能在数据中出现的字符串作为分界符，然后用它将各个数据段分开，
而对于每个数据段都对应着HTML页面表单中的一个Input区，包括一个content-disposition 属性，
说明了这个数据段的一些信息，如果这个数据段的内容是一个文件，还会有Content-Type属性，然后就是数据本身。


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
  * 公有代理和私有代理服务器  
  ＊ 代理和网关的区别 
  
  代理： 
             http 
  Web Client ---->
 
 
