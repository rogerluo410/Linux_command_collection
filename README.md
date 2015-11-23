# Linux_command_collection
Note all commands in Linux system

#URL  
GDB document : http://www.sourceware.org/gdb/current/onlinedocs/gdb.html   
autoconf & automake : http://www.cnblogs.com/itech/archive/2010/11/28/1890220.html   
                      http://www.laruence.com/2009/11/18/1154.html --for GNU   

#GNU nano 
**^G表示Ctrl+G，就是按住Ctrl键不放然后按G**  

#Git
**git config --global core.editor vim**  
**global修改的是~/.gitconfig，对当前用户有效**  

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



