# command_collection
Note all commands in Linux system and Mac.  

#URL  
GDB document : http://www.sourceware.org/gdb/current/onlinedocs/gdb.html   
autoconf & automake : http://www.cnblogs.com/itech/archive/2010/11/28/1890220.html   
                      http://www.laruence.com/2009/11/18/1154.html --for GNU   

#GNU nano 
**^G表示Ctrl+G，就是按住Ctrl键不放然后按G**  

#VIM  
光标到行首： shift+^    
光标到行未： shift+$   or  shift+a（edit mode）    

#Git
**git config --global core.editor vim**  
global修改的是~/.gitconfig，对当前用户有效

**push到github时，每次都要输入用户名和密码的问题**   
step1 配置ssh key : https://help.github.com/articles/generating-ssh-keys/   
step2 git remote set-url origin git@github.com:USERNAME/REPOSITORY2.git   
> http://blog.csdn.net/yuquan0821/article/details/8210944  

**git 分支合并与冲突**  
git branch branch_name           -- 创建分支  
git checkout branch_name         -- 切换分支  
git pull origin master:slave     -- 用远端origin主机的master分支更新本地slave分支  
git diff                         -- 如果有文件冲突,diff出冲突处，手动修改/删除`>>>>head  code  <<<<< `中的代码    
git commit -a -M "Update with master"  --本地slave分支提交到origin主机的slave分支即可      

#Thread
**top -H -p pid命令查看进程内各个线程占用的CPU百分比**  
```
PID USER      PR  NI  VIRT  RES  SHR S %CPU MEM    TIME+  COMMAND                         

14086 root      25   0  922m 914m 538m R  101 10.0  21:35.46 gateway                          

14087 root      25   0  922m 914m 538m R  101 10.0  10:50.22 gateway                           

14081 root      25   0  922m 914m 538m S   99 10.0   8:57.36 gateway                            

14082 root      25   0  922m 914m 538m R   99 10.0  11:51.92 gateway                              

14089 root      25   0  922m 914m 538m R   99 10.0  21:21.77 gateway                             

14092 root      25   0  922m 914m 538m R   99 10.0  19:55.47 gateway                               

14094 root      25   0  922m 914m 538m R   99 10.0  21:02.21 gateway                                

14083 root      25   0  922m 914m 538m R   97 10.0  21:32.39 gateway                                 

14088 root     25   0  922m 914m  538m R  97 10.0   11:23.12  gateway
```  

**使用gcore命令转存进程映像及内存上下文**  
```
gcore 14094
该命令生成core文件core.14094
```

**用gdb调试core文件，并线程切换到37号线程.gcore和实际的core dump时产生的core文件几乎一样，只是不能用gdb进行某些动态调试**  
```
(gdb) gdb gateway core.14094 
(gdb) thread 37
[Switching to thread 37 (Thread 0x4696ab90 (LWP 14086))]#0  0x40000410 in __kernel_vsyscall ()
(gdb) where
#0  0x40000410 in __kernel_vsyscall ()
#1  0x40241f33 in poll () from /lib/i686/nosegneg/libc.so.6

可以根据详细的函数栈进行gdb调试，打印一些变量值，并结合源代码分析为何会poll调用占用很高的CPU。
```  

#Sever performance commands  


#Postgresql  
`Create db`  : createdb dbname -O username -E UTF8 -e  
`Access to`  : psql -U username -d dbname -h 127.0.0.1  
`List `      : psql -l  
`Access one` : \c dbname  
`Show tables`: \d  



#Nginx for Mac    
`Install`   :  brew install nginx   
             nginx -V    --查看版本，以及配置文件地址   
`配置文件地址`: /usr/local/etc/nginx/nginx.conf     

`重新加载配置|重启|停止|退出 nginx`  
nginx -s reload|reopen|stop|quit   



#curl  
`Get request with parameters IN URL:`  
curl http://localhost:3000/api/backend/taxonomies?params1=1&params2=2   

`POST request with JSON data:`       
curl -d '{"taxonomy":{"name": "stone","colour" : "black","depth":"deep","pattern":"cloud","use":"building"}}' 'http://localhost:3000/api/backend/taxonomies' -H Content-Type:application/json -v    

`PUT`   
curl  -H 'Content-Type: application/json' -H 'Accept: application/json' -X PUT -d '{"name": "stone_upd","colour" : "blue","depth":"deep","pattern":"cloud","use":"art","position":0}'  'http://localhost:3000/api/backend/taxonomies/10'   
