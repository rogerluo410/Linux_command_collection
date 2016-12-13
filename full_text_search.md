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
  esplugin install analysis-smartcn
