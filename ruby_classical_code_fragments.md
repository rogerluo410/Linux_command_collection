# Classical source code fragments 

类型检查， is_a的用法 
```
unless attributes_collection.is_a?(Hash) || attributes_collection.is_a?(Array)
   raise ArgumentError, "Hash or Array expected, got #{attributes_collection.class.name} (#{attributes_collection.inspect})"
end
```  

endpoint 的典型用法
```
attributes_collection = if keys.include?('id') || keys.include?(:id) #开放客户传入hash，需要判断key是字符串还是标签
  [attributes_collection]
else
  attributes_collection.values
end
```



# Coding world  

**面向对象**  

***编程和面向对象的关系***  

**数据抽象和继承**  

**多重继承的缺点**  

***Duck Typing**  

***元编程***  
