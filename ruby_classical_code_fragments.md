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

**1.面向对象**  

***(1)编程和面向对象的关系***  

***(2)数据抽象和继承***  

***(3)多重继承的缺点***  

***(4)Duck Typing***    

***(5)元编程***  


＃ Directory and File  

 Check type:  
```
File.exist?(bashrc)
File.file?(bashrc)  
File.directory?(bashrc)
File.symlink?(path_to_file)
```

Code :  

```ruby  
# release business js which is in the view file to individual file.
# gsub 字符串替换。
source_path = './app/views'

dest_path = './app/assets/javascripts/controller'

filter_directory_list = [
  "layouts", 
  "create_user_notice_mailer", 
  "deliver_notice_mailer", 
  "home", 
  "kaminari", 
  "order_confirm_mailer", 
  "overdue_mailer", 
  "profile_mailer", 
  "quotation_mailer", 
  "user_mailer"
]

def replace(filepath, regexp, *args, &block)
  content = File.read(filepath).gsub(regexp, *args, &block)
  File.open(filepath, 'wb') { |file| file.write(content) }
end

def write_js_to_new_file(source_file, output_file)
  content = File.read(source_file).match(/<script\b[^>]*>([\s\S]*?)<\/script>/)

  unless content.nil?
    #File::new(output_file, "a") unless File.exists? output_file
    File.open(output_file, "a") do | f |
      f.write(content[1])
    end
    return true
  end
  return false
end

def annotate_js_in_source(source_file, file_name)
  replace(source_file, /<script\b[^>]*>/) { |match| file_name[0] == '_'?  "<%= asset_load \"controller/\#\{controller_path\}/#{file_name.split('.')[0]}\"%>\n<!--#{match}" : "<!--#{match}"}
  replace(source_file, /<\/script>/) { |match| "#{match}-->"}
end

def add_trace_log(source_file, dest_file, state)
  File.open("./rebuild_js_log.txt", "a+") do | f |
    f.write("#{source_file}  [to]  #{dest_file}  [is]  #{state}\n")
  end
end

lam_block = lambda do | source, dest, entry | 
  if File.directory? File.join(source, entry) and !(entry =='.' || entry == '..') and !filter_directory_list.include?(entry)
    Dir::mkdir(File.join(dest, entry)) unless File.exists? File.join(dest, entry)

    Dir.entries(File.join(source, entry)).each do | second_entry |
      lam_block.call("#{source}/#{entry}", "#{dest}/#{entry}", second_entry)
    end
  else
    if !(entry =='.' || entry == '..') and entry.split('.')[1] == 'html'
      if write_js_to_new_file("#{source}/#{entry}", "#{File.join(dest, entry.split('.')[0])}.js")
        annotate_js_in_source("#{source}/#{entry}", entry)
        #add_trace_log("#{source}/#{entry}", "#{File.join(dest, entry.split('.')[0]) }.js", "success")
      else
        #add_trace_log("#{source}/#{entry}", "#{File.join(dest, entry.split('.')[0]) }.js", "failure")
      end
    end
  end
end

#Start
Dir.entries(source_path).each do |entry| 
  lam_block.call(source_path, dest_path, entry)
end

```
