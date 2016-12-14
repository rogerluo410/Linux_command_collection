# ElasticSearch

  - Install on Mac 

  brew install elasticsearch   

  - Run   
  elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml   

  - Check running successfully   
  http://localhost:9200/ 

  - Use plugin    
  ln -s /usr/local/Cellar/elasticsearch/2.3.4/libexec/bin/plugin  esplugin
  
  - Install Chinese Analysis plugin    
  esplugin install analysis-smartcn   (https://www.elastic.co/guide/en/elasticsearch/plugins/master/analysis-smartcn.html)


# 关于 ElasticSearch 

Elasticsearch不仅仅是Lucene和全文搜索，我们还能这样去描述它：  

 - 分布式的实时文件存储，每个字段都被索引并可被搜索  
 - 分布式的实时分析搜索引擎  
 - 可以扩展到上百台服务器，处理PB级结构化或非结构化数据   
 
# 集群和节点  

# 索引 ／ 文档 ／ 搜索 / 聚合 

  - 文档  
  ```
   Elasticsearch是面向文档(document oriented)的，这意味着它可以存储整个对象或文档(document)。然而它不仅仅是存储，还会索引(index)每个文档的内容使之可以被搜索。在Elasticsearch中，你可以对文档（而非成行成列的数据）进行索引、搜索、排序、过滤。这种理解数据的方式与以往完全不同，这也是Elasticsearch能够执行复杂的全文搜索的原因之一。
  ```
  
  - 和关系型数据库对比   
  Relational DB -> Databases -> Tables -> Rows -> Columns    
  Elasticsearch -> Indices   -> Types  -> Documents -> Fields   
  
  - 聚合
  Elasticsearch有一个功能叫做聚合(aggregations)，它允许你在数据上生成复杂的分析统计。它很像SQL中的GROUP BY但是功能更强大。   
   
  
  
