#Shell中引用的一些解释   
* 引用的使用   
  1.`` 反引号，系统命令输出到变量     
```
    echo "today is `date`" 
```    
  2."" 双引号 字符串输出到变量   
  3.'' 单引号 :会将引号里的所有字符，包括引号都作为一个字符串    
  4.\  反斜线 :反斜线防止shell误解其含义，即屏蔽其特殊含义。   
  5.下述字符包含有特殊意义： & * + ^ $ ` " | ?。   

* expr命令一般用于整数值，但也可用于字符串。     

* 内部参数
   $0-9 :命令行参数 $0是shell名  
   $? :程序退出狀态    
   $# :参数的总个数    
   $* :所有参数组成的字符串    


#正则表达式   

正则需要用//包围起来     

```
	  		^	行首
	  		$	行尾
	  		.	除了换行符以外的任意单个字符
	  		*	前导字符的零个或多个
	  		.*	所有字符
	  		[]	字符组内的任一字符
	  		[^]	对字符组内的每个字符取反(不匹配字符组内的每个字符)
	  		^[^]	非字符组内的字符开头的行
	  		[a-z] 小写字母
	  		[A-Z] 大写字母
	  		[a-Z] 小写和大写字母
	  		[0-9] 数字
	  		\<	单词头 单词一般以空格或特殊字符做分隔,连续的字符串被当做单词
	  		\>	单词尾   
	  		? 前导字符零个或一个
	 	 	  + 前导字符一个或多个
	  		abc|def abc或def
	  		a(bc|de)f abcf 或 adef
	  		x\{m\}   x出现m次
	  		x\{m,\}  x出现m次至多次(至少m次)
	  		x\{m,n\} x出现m次至n次  
```	  		

1.搜索行以A至Z的一个字母开头，然后跟两个任意字母，然后跟一个换行符的行.   
 
   `/^[A-Z]..$/`   

2.搜索以一个大写字母开头，后跟0个或多个小写字母，再跟数字3，再跟0—5之间的一个数字。     

  ` /^[A-Z][a-z]*3[0-5]/`   

3.搜索以0个或多个空格开头，跟一个大写字母，两个小写字母和一个换车符。将找到第4行的TOM（整行匹配）和第5行。注意，*前面有一个空格。   

  `/^ *[A-Z][a-z]\{2\}$/`   

4.将查找以0个或多个大写或小写字母开头，不跟逗号，然后跟0个或多个大写或小写字母，然后跟一个换车符。   

  `/^[A-Za-z]*[^,][A-Za-z]*$/`   


EMAIL: ` /^[A-Za-z0-9]\{3,15\}\@`   
PHONE:  
UERNAME:   
USERPASSWD:    


#grep的使用  
###grep & egrep
* 缺省情况下， grep是大小写敏感的，如要查询大小写不敏感字符串，必须使用-i开关.    

* 在grep命令中输入字符串参数时，最好将其用双引号括起来。例如：“my string”。这样做
有两个原因，一是以防被误解为shell命令，二是可以用来查找多个单词组成的字符串.   

* grep和正则表达式,用'正则'将正则表达式命令引起来.并且不需要将正则//起来   
``` 
  grep '/^n/' datafile----> no  
  grep '^n' datafile -----> yes
```     

1.打印datafile中包含NW的行   

     `grep "NW" datafile`   

2.打印所有以d开头的文件中含有NW的文件  

     `grep "NW" d*`   

3.打印文件datafile中所有以字母n开头的行

     `grep '^n/' datile`   

4.在Savage和datafile文件中查找有TB的行

     `grep "TB" datafile`   

5.在datafile文件中查找含有TB Savage的行并打印
 
     `grep "TB Savage" datafile`   

6.打印datafile中以w或者e开头的行
 
     `grep '^[we]' datafile`   

7.打印所有包含一个s并跟0个或者多个s，然后跟一个空格的行

     `grep 's*[\ ]'  datafile`  

      egrep could use extensible  + , ? , | ,()
          --lov(ely|able)  
          --与lovely或lovable匹配     
          
8.打印所有这样的行：它包含一个2，后跟0个或者一个句号，然后跟一个数字。    

      `egrep '2\.?[0-9]' datafile`    

9.使用grep过滤到某些行

      `grep -v "SQL>" `    


#find 与 xargs
* 命令&&命令  命令联合使用   
  命令||命令   
  (命令;命令)的使用   

* 文件名置换   
  使用*  匹配全部  
  使用?  匹配单字符  
  使用[...] 匹配范围单字符   
  使用[!..] 不匹配范围单字符    

* find的使用   
```
find . -name -print    . 当前目录  ~ 用戶根目录  /路径名
find ~ -name  ..
find . -perm -print     --按文件的权限查找   
find / -mtime -5 -print --按文件的更改时间在5日以类查找   
find / -type d -print   --查找为目录的类型   
find / -type l -print   --查找为连接的类型     
find / -type f -print   
```

* find联合 xargs一起使用   
` find ./ -name "file name" | xargs grep -i "content"`    
有些系统对能够传递给exec的命令长度有限制，这样在find命令运行几分钟之后，就会出现溢出错误。    
错误信息通常是“参数列太长”或“参数列溢出”。这就是xargs命令的用处所在，特别是与find命令一起使用。     
find命令把匹配到的文件传递给xargs命令，而xargs命令每次只获取一部分文件而不是全部，不像-exec选项那样。      
 

#AWK
```
Mike Harrington:(510) 548-1278:250:100:175   
Christian Dobbins:(408) 538-2358:155:90:201   
Susan Dalsass:(206) 654-6279:250:60:50   
Archie McNichol:(206) 548-1348:250:100:175    
```

* 记录和域 awk是一行一行的读    
* NF:域的个数  NR:记录的个数  
* $0:整行记录  $1...N : 列   
* 域分隔符 -F[:] 分隔冒号     
* -f 使用awk文件     
* 表达式要用{}括起来 , 整个程序要用''引起来       
* 匹配操作符(~)、否定号(!)用来与一条记录或域里的表达式相匹配。正则表达式匹配运算符    
     ~ 与正则表达式相匹配    x~/y/   
    !~ 不与正则表达式相匹配  x!~/y/     
* 隐式if表达式可以不用{}括起来        

如要杀自己进程，请用：   
`ps -ef|grep name|awk '{print "kill " $2 }'|sh `  

1.打印所有的电话号码   

 `awk '{print NR,$3}' donors`

2.打印Dan的电话号码   

 `awk '/\<Mike/{print $3}' donors`

3.打印Susan的名字和电话号码  

 `awk '/\<Susan/{print $1,$3}' donors`

4.打印所有以D开头的姓   

 `awk '/[\ ]D[a-z]*\:/{print $2}' donors`   

5.打印所有以一个C或E开头的名    

  `awk '/^[CE]/{print $1}' donors`

6.打印所有只有四个字符的名   
  
  `awk '{print $1}' donors`

7.打印所有那些区号是206的名   

  `awk '/\:\(206\)/{print $1}' donors`

8.打印Mike的活动捐款。打印每个值时都要以一个美元符号打头；例如：$500$200$300    
  --print auto nextline,  --printf no nextline defaultly    
  `awk '/\<Mike/{print $3}' donors | awk -F[:] '{print "$"$2"$"$3"$"$4}' `       
  `awk '/\<Mike/{print $3}' donors | awk -F[:] '{printf "$%s$%s$%s\n",$2,$3,$4}'`    
  `awk -F: '/^Mike/{printf "$%d$%d$%d\n",$3,$4,$5}' donors`     

9.打印姓，其后跟一个逗号和名   

  `awk '{print $2","$1}' donors`  

10.打印那些第一个月捐款超过100的人的姓名   

  `awk -F[:] '$3>100 {print $1}' lab4.data`

11.打印那些第一个月捐款少于$60的人的姓名和电话号码    

  `awk -F[:] '$3<60 {print $1,$2}'  lab4.data`

12.打印那些第三个月捐款在90到150之间的人    

  `awk -F[:] '$3<150&&$3>90 {print $0}' lab4.data`

13.打印那些三个月捐款在800以上的人   

  `awk -F[:] '$3+$4+$5>800 {print $0}'  lab4.data`

14.打印那些平均每月捐款大于$150的人名和点话号码    

  `awk -F[:]  '($3*$4*$5)/3>150 {print $1,$2}' lab4.data`   

15.打印那些区号不是916的人名   

  `awk -F[:\t] '$3!~/916/{print $1}' lab4.data`

16.打印每条记录，记录号在前面     

  `awk '{print NR" "$0}'  lab4.data`  

17.打印每个人的名字和捐款总额      

  `awk -F[:] '{MAX=$3+$4+$5; print $1,MAX}'  lab4.data`  

18.把Elizabeth的第二次捐款加上$10    
   
  `awk -F[:]  '$1~/\<Elizabeth/{$4=$4+10;print $0}'  lab4.data`

19.把Nancy McNeil的名字改成Louise McInnes    

  `awk -F[:]  '$1~/\<Nancy McNeil/{$1="Louise McInnes";print $0}' lab4.data  --字符串赋值`   


#Normal USE  
1.basename  从路徑中分离出文件名 常用在shell中       
basename  路径-->basename /home/eclipse/script       

2.cp -r 拷贝相应的目录及其子目录      

3.diff  -i file1 file2 比较2个文件内容的不同   
        -i :忽略大小写  -c:按照标准格式输出   

4.dircmp 比较2个目录   --ubuntu中没这个命令     

5.du 显示的磁盘空间占用是以512字节的块来表示的。它主要用于显示目录所占用的空间。   
-a:显示每个文件的大小，不仅是整个目录所占用的空间   
-s:只显示总计    

6.file 用来确定文件的类型     

7.fuser 可以显示访问某个文件或文件系统(终端)的所有进程   
-k:杀死所有访问该文件或文件系统的进程。  
-u:显示访问该文件或文件系统的所有进程。   

8.logname 显示当前所使用的登录用户名    

9.nl 用于在文件中列行号，在打印源代码或列日志文件时很有用。   
-i:行号每次增加n；缺省为1。   
-p:在新的一页不重新计数。   

10.strings 可以看二进制文件中所包含的文本     

11.tty 报告所连接的设备或终端    

12.uname 显示当前操作系统名及其他相关信息   
-a：显示所有信息。   
-s：系统名。   
-v：只显示操作系统版本或其发布日期。   

13.系统信息及运行状态监控    
  Linux 的文件系统中有一个特殊目录/proc 该目录下列出的文件并非保
存在磁盘上而是内存中的一个映像在该目录下可以找到许多有意思的东西
```   
/proc/cpuinfo 本机 CPU的相关信息
/proc/meminfo 本机内存及交换分区的使用信息
/proc/modules 本机已安装的硬件模块信息
/proc/mounts  本机已挂载 mount 上的设备信息
```
此外该目录下有一些以数字为名称的子目录每个子目录用于维护一个正
在运行的进程而目录名即为相应的进程ID。   

14.iostat  -d   
显示的 IO 统计信息中各部分说明如下:   
tps 设备每秒收到的 IO 传送请求数   
Blk_read/s 设备每秒读入的块数量   
Blk_wrtn/s 设备每秒写入的块数量   
Blk_read 设备读入的总块数量   
Blk_wrtn 设备写入的总块数量   


15.Free命令 
该命令在linux下有,在AIX5.2下没有查看内存、缓冲区、交换空间的占用       
-b 以字节为单位显示数值   
-k 以千字节为单位显示数值    
-m 以兆字节为单位显示数值    
-t 统计结果   
-s <秒> 刷新频率    

  
16.mount和umount 挂载設备
mount 命令有很多参数其中大多数都不会在日常工作中用到mount命令.      
最常见的用法如下所示:      
   `mount [选项] 设备目录`   
其中最常用的选项是:    
   `-a 把/etc/fstab 文件中列出的文件系统都挂装上`         
   
挂装软驱和光驱的命令比较简单,直接输入以下命令即可:      
```
   mount /mnt/cdrom   
   mount /mnt/floppy  
```   
umount命令用于卸载一个文件系统命令的格式如下:       
   `umount [ -f ] directory`   
其中directory是准备卸载的目录名        

17.tar   
tar 命令用于把多个文件合并于一个档案文件中并提供分解的合并后的档案文件的功能.  
它独立于压缩工具因此可以选择在合并前是否压缩tar命令的基本用法为:       
`tar [选项] 文件名 `  
常用的选项包括:    
-c 创建一个新的档案文件  
-t 查看档案文件的内容  
-x 分解档案文件的内容  
-f 指定档案文件的名称  
-v 显示过程信息   
-z 采用压缩方式   
```
Eg：
   tar -cf  all.tar  *.jpg    --归档该目录下所有的jpg文件
   tar -cf  all.tar  dirname  --归档整个目录
   tar -rf  all.tar  11.jpg   --将11.jpg 归档到已存在的all.tar的归档文件中
   tar -tf  all.tar           --列出包中所有文件的信息
   tar -czf jpg.tar.gz *.jpg  --打包成jpg.tar 后 并且将其用gzip压缩，生成一个gzip压缩过的包，包名为jpg.tar.gz    (在AIX上测试没有 -z这个参数)
```     


18.网络配置及操作     
* Linux 系统中最常用的网络配置命令包括ifconfig route.        
* Linux 系统常用的网络操作命令包括netstat nslookup host finger 和ping.       
* 在Linux系统中TCP/IP网络是通过若干个文本文件进行配置的需要编辑       
这些文件来完成联网工作系统中重要的有关网络配置文件为:          
```
/etc/sysconfig/network  该文件用来指定服务器上的网络配置信息
/etc/hosts              IP 地址和主机名的映射
/etc/services           包含了服务名和端口号之间的映射
/etc/host.conf          配置名字解析器
/etc/nsswitch.conf      配置名字解析器
/etc/resolv.conf        配置DNS 客户
/etc/xinetd.conf
/etc/modules.conf
/etc/sysconfig/network-scripts/ifcfg-ethN
```   

19.lsof -i:25830 查看所指定端口运行的程序，还有当前连接。       

20.pkill -KILL -U `awk -F":" '$1 == "wujie" {print $3;}' /etc/passwd` 查找某用户（wujie），结束它的相关进程    

21.抓包分析   

   `tcpdump -nn port 9090 -w /var/001.cap`  

   这意思是监听 9090 端口，将监听到的数据保存到 001.cap文件      


22.找端口结束相应程序    
```
kill `netstat -lantp | grep :3306 | grep -v tcp6 | awk '{print $7}' | sed 's/[a-z].*//' | sed 's/\///'`
```  
这条命令，实际上是结束mysql的命令，3306是mysql的端口。是通过查找端口，结束相应的程序。用到了正则表达式     


23.使用 cp -rf 移动一个目录到另一个目录下成为它的子目录，同名的目录不会覆盖      

24.非交互式sql,ftp脚本   
```
sqlplus $userpwd<<!
set pagesize 0
set linesize 500
set termout off
set heading off
set head off
set trimspool on
set colsep ','
set feedback off
spool TEMP.TXT
select distinct jf_bill_id from $table_name;
spool off
quit
!
访问数据库的操作,在shell中的写法。   
```

在ftp命令中使用 << 时，使用了ftp -i -n选项，这意味着不要自动登录，而且关闭交互模式。    
```
ftp -i -n  $DEST_HOST << FTPIT
user  $ftp_username $ftp_userpsd
ascii
prompt off 
get   XXX
quit
FTPIT
```  

25.tail  sort uniq cut 等合并与分割命令的使用  
* 查看系统里所有用户的进程   
`ps -e -o user | tail -n +2 | sort | uniq -c`    

26.对 2>&1 重定向的理解   
`grep "standard"* > grep.out 2>&1`   

该操作的目的是将grep的行标准输出到grep.out这个文件中，通过2>&1,可以做到把输出到grep.out文件中的错误也一并保存到grep.out这个文件中。     
* command <&m 把文件描述符m作为标准输入  
* command >&m 把标准输出重定向到文件描述符m中   
* command <&- 关闭标准输入    
* 2>&1,  1文件描述符本身就代表标准输出     

27.写shell脚本的一些知识点和心得    
* 命令的返回状态     
命令成功返回0 ，失败返回1.   
所以在自定义函数时，也应该成功返回0,失败返回1。     

* 文件置换符 *     
在shell中使用文件置换符，例如file="ydds_*.txt"     
 ydds_*.txt: 文件置换为第一个匹配的字符串 ydds_201107.txt则file取引用($file)为ydds_201107.txt.       

